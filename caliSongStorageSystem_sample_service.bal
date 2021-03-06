import ballerina/grpc;
import ballerina/io;
import ballerina/crypto;
import ballerina/mongodb;
import ballerina/lang.'float;

listener grpc:Listener ep = new (9090);



mongodb:ClientConfig mongoConfig = {
        host: "localhost",
        port: 27017,
        // username: "admin",
        // password: "admin",
        options: {sslEnabled: false, serverSelectionTimeout: 6000}
    };
    mongodb:Client serverDatabase = checkpanic new (mongoConfig);
    mongodb:Database mongoDatabase = checkpanic serverDatabase->getDatabase("RecordCali");
    mongodb:Collection mongoCollection = checkpanic mongoDatabase->getCollection("record");

service caliSongStorageSystem on ep {

    resource function writerecord(grpc:Caller caller, calirecord value) {
        // Implementation goes here.
                                
         string r="1.0";
            
            string hashkey = requestedRecord.toString();
            byte[] hashByte = hashkey.toBytes();
            byte[] KeyHash = crypto:hashMd5(hashByte);
            
             map<json>|error JsonFile = map<json>.constructFrom(requestedRecord);
             map<json> Assigning = <map<json>>JsonFile;
             Assigning["record_key"]=KeyHash.toBase16();
             string kv=KeyHash.toBase16();
                                
          if (JsonFile is error)
          {
              io:println("Error");
          }
          else
          {
              io:println("dataBase");

             map<json> [] AllSpecificRecord= checkpanic  mongoCollection->find({"record_key":KeyHash.toBase16()});
             
            if (AllSpecificRecord.length()>0)
            {
                    io:println("=========ALL THE RECORDS THAT HAVE THE KEY ",kv," =====================");
                    io:println(AllSpecificRecord.toJsonString());
                    float [] kvfArray=[];
                     int i=0 ;
                    foreach var item in AllSpecificRecord {
                        if (item.record_key==kv)
                        {
                        
                            io:println("------------RECORDS WITH THAT KEY-----------");
                            io:println(item);
                            string jkv=<string>item.record_version;
                            float|error kvf = 'float:fromString(jkv);
                                    kvfArray[i]=<float>kvf;
                                    i+=1;
                        }   
                    }       
                    if there is a/are record/s with the current record key
            
                    float greatestVersion=kvfArray[0];
                    foreach var item in kvfArray {
                        if (item>greatestVersion) {
                            greatestVersion=item;
                                                        
                        }
                        
                    }
                
                        r=greatestVersion.toString().substring(0,3);   
                        io:println(JsonFile);
                        keyVersion result={record_key:KeyHash.toBase16(),record_version:r};
                        var res=ResponseRecord->send(result);
                        res=ResponseRecord->complete();
                        r="1.0";
                        io:println("This record already exist.");
                        
               }
                 
                   else {
                        io:println("There is no record in the database with this key, it is a new record!!!");
                        Assigning["record_version"]=r;
                        io:println(JsonFile);
                        keyVersion result={record_key:KeyHash.toBase16(),record_version:r};
                        checkpanic mongoCollection->insert(JsonFile);
                        var    res=ResponseRecord->send(result);
                        res=ResponseRecord->complete();
            }
                    
          }
          // Getting the last version of the record with that key
                    float greatestVersion=kvfArray[0];
                    foreach var item in kvfArray 
                    {
                        if (item>greatestVersion) 
                        {
                            greatestVersion=item;
                                                        
                        }
                        
                    }
                        greatestVersion+=0.1;
                         string r=greatestVersion.toString().substring(0,3);
                         map<json> Assigning = <map<json>>JsonFile1;
                         Assigning["record_key"]=updateRequest.record_key;
                         Assigning["record_version"]=r;
                         io:println("---------------RECORD cali inside the updateRecord ----------");
                         io:println(JsonFile1.toString());
                         keyVersion result={record_key:updateRequest.record_key,record_version:r};
                         var res=updateResponse->send(result);
                         res=updateResponse->complete();
                         map<json> filedb=<map<json>>JsonFile1;
                         io:println("---------------------------Record copy sent to the database----------------------");
                         checkpanic mongoCollection->insert(filedb);     
        }
        }
        else{
            io:println("There is no record with this key and version!!!");
        }
                                
        // You should return a keyVersion
    }
    resource function updateRecord(grpc:Caller caller, UpdateRecordCopy value) {
        // Implementation goes here.
        io:println("-------------UPDATE-------------");
        map<json>|error JsonFile = map<json>.constructFrom(updateRequest);
         io:println("---------------objecct RECORD----------");
        io:println(updateRequest.toString());
        io:println("---------------JSON UPDATE RECORD----------");
        io:println(JsonFile.toString());
        
        map<json>|error JsonFile1 = map<json>.constructFrom(updateRequest.recordCopy);
        //The record with that version and key
        map<json> [] SpecificRecord = checkpanic  mongoCollection->find({"record_key":updateRequest.record_key,"record_version":updateRequest.record_version});
        if (SpecificRecord.length()>0) {
                io:println("--------------Records from database with key nd version-------------");
                io:println(SpecificRecord.toString());
        //Looking for the last version using only the , they might have more then one record with that key 
         map<json> [] AllSpecificRecord= checkpanic  mongoCollection->find({"record_key":updateRequest.record_key});
         string kv=updateRequest.record_key;
        // You should return a keyVersion
        if (AllSpecificRecord.length()>0)
            {
                    io:println("=========ALL THE RECORDS THAT HAVE THE KEY ",kv," =====================");
                    io:println(AllSpecificRecord.toJsonString());
                    float [] kvfArray=[];
                    int i=0 ;
                    foreach var item in AllSpecificRecord
                    {
                        if (item.record_key==kv)
                        {
                        
                            io:println("------------RECORDS WITH THAT KEY-----------");
                            io:println(item);
                            string jkv=<string>item.record_version;
                            float|error kvf = 'float:fromString(jkv);
                                    kvfArray[i]=<float>kvf;
                                    i+=1;
                        }  
                    }
                    float greatestVersion=kvfArray[0];
                    foreach var item in kvfArray 
                    {
                        if (item>greatestVersion) 
                        {
                            greatestVersion=item;
                                                        
                        }
                        
                    }
                        greatestVersion+=0.1;
                         string r=greatestVersion.toString().substring(0,3);
                         map<json> Assigning = <map<json>>JsonFile1;
                         Assigning["record_key"]=updateRequest.record_key;
                         Assigning["record_version"]=r;
                         io:println("---------------RECORD cali inside the updateRecord ----------");
                         io:println(JsonFile1.toString());
                         keyVersion result={record_key:updateRequest.record_key,record_version:r};
                         var res=updateResponse->send(result);
                         res=updateResponse->complete();
                         map<json> filedb=<map<json>>JsonFile1;
                         io:println("---------------------------Record copy sent to the database----------------------");
                         checkpanic mongoCollection->insert(filedb);     
        }
        }
        else{
            io:println("There is no record with this key and version!!!");
        }
    }
    resource function ReadRecordKey(grpc:Caller caller, keyReading value) {
        // Implementation goes here.

        string kv=value.record_key;
            map<json> [] AllSpecificRecord= checkpanic  mongoCollection->find({"record_key":value.record_key});
            if (AllSpecificRecord.length()>0)
            {
                    io:println("=========ALL THE RECORDS THAT HAVE THE KEY ",kv," =====================");
                    io:println(AllSpecificRecord.toJsonString());
                    float [] kvfArray=[];
                    int i=0 ;
                    
                    foreach var item in AllSpecificRecord {
                        if (item.record_key==kv)
                        {
                        
                            io:println("------------RECORDS WITH THAT KEY-----------");
                            io:println(item);
                            string jkv=<string>item.record_version;
                            float|error kvf = 'float:fromString(jkv);
                                    kvfArray[i]=<float>kvf;
                                    i+=1;
                        }

                        
                    }
                    
                    
                // if there is a/are record/s with the current record key
            
                    float greatestVersion=kvfArray[0];
                    foreach var item in kvfArray {
                        if (item>greatestVersion) {
                            greatestVersion=item;
                                                        
                        }
                        
                    }
                        string r=greatestVersion.toString().substring(0,3); 
                        //Getting the record that has the last version
                        map<json> [] RecordLastVersion= checkpanic  mongoCollection->find({"record_key":value.record_key,"record_version":r});  
                        var res=caller->send(RecordLastVersion.toString());
                        res=caller->complete();
            }
            else
            {
                io:println("There is no record with this key!!!");
            }
        // You should return a calirecord
    }
    resource function ReadRecordKeyVersion(grpc:Caller caller, keyVersion value) {
        // Implementation goes here.
                
                 map<json> [] RecordVersionKey = checkpanic  mongoCollection->find({"record_key":value.record_key,"record_version":value.record_version});
         if (RecordVersionKey.length()>0) {
                io:println("--------------Records from database with key nd version-------------");
               io:println(RecordVersionKey.toString());
               var res=caller->send(RecordVersionKey.toString());
                res=caller->complete();
         }
         else{
             io:println("There is no record wiht such key and version!!!");
         }
        // You should return a calirecord
    }
    resource function ReadCriterionCombination(grpc:Caller caller, CriterionCombination value) {
        // Implementation goes here.
         io:println("--------------------------All records by band name-----------------------");
         map<json> [] bands = checkpanic  mongoCollection->find({"band":value.bandName});
         if (bands.length()>0) {
                io:println("--------------Records from database BAND-------------");
               io:println(bands.toString());
         }
         else{io:println("There is no record with that band name!!!");}
         
         
           io:println("--------------------------All records by date-----------------------");
         map<json> [] dates = checkpanic  mongoCollection->find({"date":value.SongDate});
         if (dates.length()>0) {
                io:println("--------------Records from database dates-------------");
               io:println(dates.toString());
         }
         else{io:println("There is no record with that date!!!");}
         
          io:println("--------------------------All records by version-----------------------");
         map<json> [] versions = checkpanic  mongoCollection->find({"record_version":value.record_version});
         if (version.length()>0) {
                io:println("--------------Records from database dates-------------");
               io:println(version.toString());
         }
         else{io:println("There is no record with that date!!!");}
         json all[]=[];
         all[0]=bands;
         all[0]=dates;
         all[0]=versions;
         
         io:println("---------------------------Record copy sent to the client----------------------");
                       calirecord result=caller->send(all.toString());
         
        // You should return a TotalRecords
    }
}

public type TotalRecords record {|
    calirecord[] records = [];
    
|};

public type CriterionCombination record {|
    string SongDate = "";
    string record_version = "";
    string bandName = "";
    
|};

public type keyReading record {|
    string record_key = "";
    
|};

public type UpdateRecordCopy record {|
    string record_key = "";
    string record_version = "";
    calirecord? recordCopy = ();
    
|};

public type keyVersion record {|
    string record_key = "";
    string record_version = "";
    
|};

public type Artist record {|
    string name = "";
    Member? member = ();
    
|};

public type Member "YES"|"NO";
public const Member MEMBER_YES = "YES";
const Member MEMBER_NO = "NO";

public type Song record {|
    string title = "";
    string genre = "";
    string platform = "";
    
|};

public type calirecord record {|
    string date = "";
    Artist[] artists = [];
    Song[] songs = [];
    string band = "";
    string record_key = "";
    string record_version = "";
    
|};



const string ROOT_DESCRIPTOR = "0A0F63616C6970726F746F2E70726F746F22350A0C546F74616C5265636F72647312250A077265636F72647318012003280B320B2E63616C697265636F726452077265636F72647322750A14437269746572696F6E436F6D62696E6174696F6E121A0A08536F6E67446174651801200128095208536F6E674461746512250A0E7265636F72645F76657273696F6E180220012809520D7265636F726456657273696F6E121A0A0862616E644E616D65180320012809520862616E644E616D65222B0A0A6B657952656164696E67121D0A0A7265636F72645F6B657918012001280952097265636F72644B65792285010A105570646174655265636F7264436F7079121D0A0A7265636F72645F6B657918012001280952097265636F72644B657912250A0E7265636F72645F76657273696F6E180220012809520D7265636F726456657273696F6E122B0A0A7265636F7264436F707918032001280B320B2E63616C697265636F7264520A7265636F7264436F707922520A0A6B657956657273696F6E121D0A0A7265636F72645F6B657918012001280952097265636F72644B657912250A0E7265636F72645F76657273696F6E180220012809520D7265636F726456657273696F6E225F0A0641727469737412120A046E616D6518012001280952046E616D6512260A066D656D62657218022001280E320E2E4172746973742E4D656D62657252066D656D62657222190A064D656D62657212070A03594553100012060A024E4F1001224E0A04536F6E6712140A057469746C6518012001280952057469746C6512140A0567656E7265180220012809520567656E7265121A0A08706C6174666F726D1803200128095208706C6174666F726D22BA010A0A63616C697265636F726412120A046461746518012001280952046461746512210A076172746973747318022003280B32072E417274697374520761727469737473121B0A05736F6E677318032003280B32052E536F6E675205736F6E677312120A0462616E64180420012809520462616E64121D0A0A7265636F72645F6B657918052001280952097265636F72644B657912250A0E7265636F72645F76657273696F6E180620012809520D7265636F726456657273696F6E328F020A1563616C69536F6E6753746F7261676553797374656D12270A0B77726974657265636F7264120B2E63616C697265636F72641A0B2E6B657956657273696F6E122E0A0C7570646174655265636F726412112E5570646174655265636F7264436F70791A0B2E6B657956657273696F6E12290A0D526561645265636F72644B6579120B2E6B657952656164696E671A0B2E63616C697265636F726412300A14526561645265636F72644B657956657273696F6E120B2E6B657956657273696F6E1A0B2E63616C697265636F726412400A1852656164437269746572696F6E436F6D62696E6174696F6E12152E437269746572696F6E436F6D62696E6174696F6E1A0D2E546F74616C5265636F726473620670726F746F33";
function getDescriptorMap() returns map<string> {
    return {
        "caliproto.proto":"0A0F63616C6970726F746F2E70726F746F22350A0C546F74616C5265636F72647312250A077265636F72647318012003280B320B2E63616C697265636F726452077265636F72647322750A14437269746572696F6E436F6D62696E6174696F6E121A0A08536F6E67446174651801200128095208536F6E674461746512250A0E7265636F72645F76657273696F6E180220012809520D7265636F726456657273696F6E121A0A0862616E644E616D65180320012809520862616E644E616D65222B0A0A6B657952656164696E67121D0A0A7265636F72645F6B657918012001280952097265636F72644B65792285010A105570646174655265636F7264436F7079121D0A0A7265636F72645F6B657918012001280952097265636F72644B657912250A0E7265636F72645F76657273696F6E180220012809520D7265636F726456657273696F6E122B0A0A7265636F7264436F707918032001280B320B2E63616C697265636F7264520A7265636F7264436F707922520A0A6B657956657273696F6E121D0A0A7265636F72645F6B657918012001280952097265636F72644B657912250A0E7265636F72645F76657273696F6E180220012809520D7265636F726456657273696F6E225F0A0641727469737412120A046E616D6518012001280952046E616D6512260A066D656D62657218022001280E320E2E4172746973742E4D656D62657252066D656D62657222190A064D656D62657212070A03594553100012060A024E4F1001224E0A04536F6E6712140A057469746C6518012001280952057469746C6512140A0567656E7265180220012809520567656E7265121A0A08706C6174666F726D1803200128095208706C6174666F726D22BA010A0A63616C697265636F726412120A046461746518012001280952046461746512210A076172746973747318022003280B32072E417274697374520761727469737473121B0A05736F6E677318032003280B32052E536F6E675205736F6E677312120A0462616E64180420012809520462616E64121D0A0A7265636F72645F6B657918052001280952097265636F72644B657912250A0E7265636F72645F76657273696F6E180620012809520D7265636F726456657273696F6E328F020A1563616C69536F6E6753746F7261676553797374656D12270A0B77726974657265636F7264120B2E63616C697265636F72641A0B2E6B657956657273696F6E122E0A0C7570646174655265636F726412112E5570646174655265636F7264436F70791A0B2E6B657956657273696F6E12290A0D526561645265636F72644B6579120B2E6B657952656164696E671A0B2E63616C697265636F726412300A14526561645265636F72644B657956657273696F6E120B2E6B657956657273696F6E1A0B2E63616C697265636F726412400A1852656164437269746572696F6E436F6D62696E6174696F6E12152E437269746572696F6E436F6D62696E6174696F6E1A0D2E546F74616C5265636F726473620670726F746F33"
        
    };
}


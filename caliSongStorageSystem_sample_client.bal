import ballerina/io;
import ballerina/grpc;
public function main (string... args) {

    caliSongStorageSystemBlockingClient blockingConection = new("http://localhost:9090");
    io:println("-------------------------------write Record -----------------------");

    string input=io:readln("Enter the date:");

      calirecord song1  = {
                "date":input,
                "artists":[
                    {"name":"Me","member":"YES"},
                    {"name":"Jon","member":"YES"}
                ],  
                "songs":[
                    {"title":"Hello","genre":"Pop","platform":"home"},
                     {"title":"Rocker","genre":"Rock","platform":"home"}
                ],
                 "band":"Muzica"
                
            };
            var  getResult=  blockingConection->writerecord(song1);

               //write record
            if(getResult is grpc:Error)
            {
                io:println(getResult.reason());//.reason() will help get the error
            }
            else{
            
                keyVersion wantedw;
                grpc:Headers trash;//strange output that we don't want
                [wantedw,trash]= getResult; //both the keyVersion info we want and trash are saved in getResult
                io:println(wantedw);//this allows us to only print what we want
            }
            
            
            io:println("-------------------------------Update Record 1-----------------------");
            UpdateRecordCopy upRecordCopy1 =  {
                "record_key":"0a54d6aadf75bfe2aba4618ca85dcf31",
                "record_version":"1.0",
                "recordCopy" :{
                                    "date":"30/12/2023",
                                    "artists":[
                                        {"name":"Ana","member":"YES"},
                                        {"name":"Pedro","member":"YES"}
                                        
                                    ],  
                                    "songs":[
                                        {"title":"hi","genre":"country","platform":"distance"},
                                        {"title":"Together","genre":"RnB","platform":"Always"}
                                  

                                    ],
                                    "band":"Muzica2",
                                    record_key:"",
                                    record_version:""

                                    
                                }
            }; 
            var  getUpdateResult=  blockingConection->updateRecord(upRecordCopy1);
            io:println(typeof getUpdateResult);
             if(getUpdateResult is grpc:Error)
            {
                io:println(getUpdateResult.reason());//.reason() will help get the error
                io:println("oooooobad0ooooooo");
            }
            else{
            
                keyVersion wantedur;
                grpc:Headers trash;//strange output that we don't want
                [wantedur,trash]=  getUpdateResult; //both the keyVersion info we want and trash are saved in getupdateResult
                io:println(wantedur);//this allows us to only print what we want
            }
}
        io:println("===================Reading Record by key==================");
        keyReading key1={
                 "record_key":"0a54d6aadf75bfe2aba4618ca85dcf31"
                };
            var  getRecordByKey=  blockingConection->ReadRecordKey(key1);
            
             if(getRecordByKey is grpc:Error)
            {
                io:println(getRecordByKey.reason());//.reason() will help get the error
                io:println("oooooobad0ooooooo");
            }
            else{
            
                calirecord wantedrk;
                grpc:Headers trash;//strange output that we don't want
                [wantedrk,trash]=  getRecordByKey; //both the keyVersion info we want and trash are saved in getupdateResult
                io:println(wantedrk);//this allows us to only print what we want
            }
     io:println("===================Reading Record by key and version==================");
        keyVersion keyv={
                 "record_key":"0a54d6aadf75bfe2aba4618ca85dcf31",
                 "record_version":"1.1"
                };
            var  getRecordByKeyVersion=  blockingConection->ReadRecordKeyVersion(keyv);
            
             if(getRecordByKeyVersion is grpc:Error)
            {
                io:println(getRecordByKeyVersion.reason());//.reason() will help get the error
                io:println("oooooobad0ooooooo");
            }
            else{
            
                calirecord wantedrkv;
                grpc:Headers trash;//strange output that we don't want
                [wantedrkv,trash]=  getRecordByKeyVersion; //both the keyVersion info we want and trash are saved in getupdateResult
                io:println(wantedrkv);//this allows us to only print what we want
            }
  io:println("===================Reading record By Criterion==================");
        CriterionCombination crite={
                 "ArtistName":"Ana",
                 "SongTitle":"hi",
                 "bandName":"abc"
                };

         var  getRecordByCriterion=  blockingConection->ReadCriterionCombination(crite);
            
            if(getRecordByCriterion is grpc:Error)
            {
                io:println(getRecordByCriterion.reason());//.reason() will help get the error
                io:println("oooooobad0ooooooo");
            }
             else{
            
                TotalRecords wantedCrites;
                grpc:Headers trash;//strange output that we don't want
                [wantedCrites,trash]=  getRecordByCriterion; //both the keyVersion info we want and trash are saved in getupdateResult
                io:println(wantedCrites);//this allows us to only print what we want
            }

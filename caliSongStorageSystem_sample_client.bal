public function main (string... args) {

    caliSongStorageSystemBlockingClient blockingEp = new("http://localhost:9090");
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



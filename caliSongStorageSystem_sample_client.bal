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
}



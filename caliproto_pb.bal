import ballerina/grpc;

public type caliSongStorageSystemBlockingClient client object {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public function __init(string url, grpc:ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "blocking", ROOT_DESCRIPTOR, getDescriptorMap());
    }

    public remote function writerecord(calirecord req, grpc:Headers? headers = ()) returns ([keyVersion, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("caliSongStorageSystem/writerecord", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<keyVersion>result, resHeaders];
        
    }

    public remote function updateRecord(UpdateRecordCopy req, grpc:Headers? headers = ()) returns ([keyVersion, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("caliSongStorageSystem/updateRecord", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<keyVersion>result, resHeaders];
        
    }

    public remote function ReadRecordKey(keyReading req, grpc:Headers? headers = ()) returns ([calirecord, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("caliSongStorageSystem/ReadRecordKey", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<calirecord>result, resHeaders];
        
    }

    public remote function ReadRecordKeyVersion(keyVersion req, grpc:Headers? headers = ()) returns ([calirecord, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("caliSongStorageSystem/ReadRecordKeyVersion", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<calirecord>result, resHeaders];
        
    }

    public remote function ReadCriterionCombination(CriterionCombination req, grpc:Headers? headers = ()) returns ([TotalRecords, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("caliSongStorageSystem/ReadCriterionCombination", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<TotalRecords>result, resHeaders];
        
    }

};

public type caliSongStorageSystemClient client object {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public function __init(string url, grpc:ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "non-blocking", ROOT_DESCRIPTOR, getDescriptorMap());
    }

    public remote function writerecord(calirecord req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("caliSongStorageSystem/writerecord", req, msgListener, headers);
    }

    public remote function updateRecord(UpdateRecordCopy req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("caliSongStorageSystem/updateRecord", req, msgListener, headers);
    }

    public remote function ReadRecordKey(keyReading req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("caliSongStorageSystem/ReadRecordKey", req, msgListener, headers);
    }

    public remote function ReadRecordKeyVersion(keyVersion req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("caliSongStorageSystem/ReadRecordKeyVersion", req, msgListener, headers);
    }

    public remote function ReadCriterionCombination(CriterionCombination req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("caliSongStorageSystem/ReadCriterionCombination", req, msgListener, headers);
    }

};

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


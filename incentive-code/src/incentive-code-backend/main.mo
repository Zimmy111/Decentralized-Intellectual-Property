import Time "mo:base/Time";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Text "mo:base/Text";

actor IPRegistry {
  type IPRecord = {
    owner: Principal;
    title: Text;
    description: Text;
    timestamp: Time.Time;
  };
  let ipRecords :  HashMap.HashMap<Text, IPRecord> =  HashMap.HashMap<Text, IPRecord>(10, Text.equal, Text.hash);

  public shared({caller}) func getIP() : async ?IPRecord {
    return ipRecords.get(Principal.toText(caller));
  };

  public shared({caller}) func registerIP(title: Text, description: Text) : async Bool {
    let callerText = Principal.toText(caller);
    if (ipRecords.get(callerText) == null) {
      let newRecord = {
        owner = caller;
        title = title;
        description = description;
        timestamp = Time.now();
      };
      ipRecords.put(callerText, newRecord);
      return true;
    } else {
      return false;
    }
  };
}


import HashMap "mo:base/HashMap";
import Option "mo:base/Option";
import Result "mo:base/Result";
import Time "mo:base/Time";
import Http "mo:base/Http";
import Json "mo:base/Json";
import Debug "mo:base/Debug";

// Kullanıcı veri yapısı
type User = {
    username: Text;
    password: Text;
    registeredAt: Time;
};

// Kullanıcıları saklayan bir HashMap
var users: HashMap.HashMap<Text, User> = HashMap.HashMap<Text, User>();

// Kayıt işlemi (Create)
public func registerUser(username: Text, password: Text) : async Result<Text, Text> {
    if (users.contains(username)) {
        return #err("Bu kullanıcı adı zaten mevcut. Lütfen farklı bir kullanıcı adı seçin.");
    } else {
        let newUser: User = {
            username = username;
            password = password;
            registeredAt = Time.now();
        };
        users.put(username, newUser);
        return #ok("Kayıt başarıyla tamamlandı!");
    }
}

// Kullanıcı girişi (Read)
public func loginUser(username: Text, password: Text) : async Result<Text, Text> {
    switch (users.get(username)) {
        case (?user) {
            if (user.password == password) {
                return #ok("Başarılı giriş!");
            } else {
                return #err("Hatalı şifre!");
            }
        };
        case null {
            return #err("Kullanıcı bulunamadı!");
        };
    }
}

// Kullanıcı listesini görüntüleme (Read)
public query func listUsers() : async [User] {
    return users.values();
}

// Şifre güncelleme (Update)
public func updatePassword(username: Text, newPassword: Text) : async Result<Text, Text> {
    switch (users.get(username)) {
        case (?user) {
            let updatedUser: User = {
                username = user.username;
                password = newPassword;
                registeredAt = user.registeredAt;
            };
            users.put(username, updatedUser);
            return #ok("Şifre başarıyla güncellendi.");
        };
        case null {
            return #err("Kullanıcı bulunamadı.");
        };
    }
}

// Kullanıcı silme (Delete)
public func deleteUser(username: Text) : async Result<Text, Text> {
    if (users.remove(username) != null) {
        return #ok("Kullanıcı başarıyla silindi.");
    } else {
        return #err("Kullanıcı bulunamadı.");
    }
}

// Canister üzerinden HTTP isteği gönderme
public shared (msg) func http_request(request : Http.Request) : async Http.Response {
    try {
        // Örnek dış API isteği yapıyoruz
        let response = await Http.get(request.url);
        Debug.print("HTTP yanıtı alındı.");
        return response;
    } catch (e) {
        Debug.print("Hata: " # e);
        return {
            status_code = 500;
            headers = [];
            body = "HTTP isteği başarısız.";
        };
    }
}

// HTTP yanıtını işleme ve JSON parse etme
public func processHttpResponse(response: Http.Response) : async Text {
    let jsonResult = Json.decode(response.body);
    switch (jsonResult) {
        case (?json) {
            // JSON işleme işlemi
            Debug.print("Başarılı JSON parse: " # Json.toText(json));
            return "Başarılı JSON parse";
        };
        case null {
            return "Geçersiz JSON verisi.";
        };
    }
}

// Hata yönetimi ve eşzamanlılık (Concurrency)
public func riskyOperation() : async Result<Text, Text> {
    try {
        let result = await someAsyncFunc();
        return #ok(result);
    } catch (e) {
        return #err("İşlem sırasında hata oluştu: " # e);
    }
}

// Test amaçlı asenkron fonksiyon
private func someAsyncFunc() : async Text {
    return "Asenkron işlem tamamlandı";
}

// Trie veri yapısı (Opsiyonel olarak eklenebilir)
type TrieNode = {
    value: Option.Text;
    children: HashMap.HashMap<Char, TrieNode>;
};

public func createTrieNode(value: Option.Text) : TrieNode {
    return {
        value = value;
        children = HashMap.HashMap<Char, TrieNode>();
    };
}

var root: TrieNode = createTrieNode(null);

public func addWordToTrie(word: Text) {
    var currentNode = root;
    for (char in word.chars()) {
        switch (currentNode.children.get(char)) {
            case (?node) {
                currentNode := node;
            };
            case null {
                let newNode = createTrieNode(null);
                currentNode.children.put(char, newNode);
                currentNode := newNode;
            };
        }
    }
    currentNode.value := ?word;
}

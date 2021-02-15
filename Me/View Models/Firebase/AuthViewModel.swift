//
//  AuthViewModel.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI
import Firebase // may not need
import FirebaseAuth
import CryptoKit
import AuthenticationServices


// This typeAlias is defined just to make it simpler to deal with the tuble used in the SignInWithApple handle function once signed in.
typealias SignInWithAppleResult = (authDataResult: AuthDataResult, appleIDCredential: ASAuthorizationAppleIDCredential)

class AuthViewModel: ObservableObject {
    @Published var userSession : FirebaseAuth.User?  // keep track if user is logged in
    @Published var isAuthenticating = false // period during the log in process loading
    @Published var error : Error? // if error show alert
    @Published var user: User? // keep track of the user - Help load user data (going to use our own)
    // static -- only one isntant of that property is created
    static let shared = AuthViewModel() // shared instant -- in order to have access user, auht, user session (User?)
    
    // may not need - this is for the errors added below
    var email: String = ""
    var password: String = ""
    var fullname: String = ""
    var confirmPassword: String = ""
    
    
    
    init() {
        // SHOW THE CORRECT VIEW - IS THERE A USER ?
        userSession = Auth.auth().currentUser
        
        // GETS THE DATA
        fetchUser()
        
        
    }
    
    
    func login(withEmail email: String , password: String)  {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                print("DEBUG: Fail tp upload image \(error.localizedDescription)")
                return

            }
            
            // LOGIN USER
            self.userSession = result?.user
            self.fetchUser()
            print("DEBUG: Successfully logged in")

        }

    }
    
    
    func register(email: String , password: String , username: String , fullname: String, profileImage: UIImage) {
        
        // UPLOAD THE IMAGE UOLOADED BY NEW USER
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Fail tp upload image \(error.localizedDescription)")
            }
            
            
            storageRef.downloadURL { url, _ in
                guard let profileImageURL = url?.absoluteString else { return }
                
                
                // CREATE AUTHENTICATE NEW USER
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Error \(error.localizedDescription)")
                        return // if error - print error and stop
                    }
                    
                    print("DEBUG: Successfully signup user...")
                    print("DEBUG: Email is \(email)")
                    
                    // CHECK IF USER EXIST
                    guard let user = result?.user else { return }
                    
                    // ADD TO COLLECTION IN CLOUD FIREBASE
                    let data = ["email" : email,
                                "username" : username.lowercased(),
                                "fullname" : fullname,
                                "profileImageURL" : profileImageURL,
                                "uid" : user.uid
                    ]
                    // FETCH THE USER
                    COLLECTION_USERS
                        .document(user.uid)
                        .setData(data) { _ in
                            self.userSession = user
                            self.fetchUser() // elimiates bug on need to close app to see changes
                            print("DEBUG: Successfully uploaded user data to cloud firebase")
                        }
                }
            }
        }
    }
    
    // MARK: - Sign In with Email functions
    
    static func resetPassword(email:String, resetCompletion:@escaping (Result<Bool,Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if let error = error {
                resetCompletion(.failure(error))
            } else {
                resetCompletion(.success(true))
            }
        }
        )}
    
    
    static func authenticate(withEmail email :String,
                             password:String,
                             completionHandler:@escaping (Result<Bool, EmailAuthError>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            // check the NSError code and convert the error to an AuthError type
            var newError:NSError
            if let err = error {
                newError = err as NSError
                var authError:EmailAuthError?
                switch newError.code {
                case 17009:
                    authError = .incorrectPassword
                case 17008:
                    authError = .invalidEmail
                case 17011:
                    authError = .accoundDoesNotExist
                default:
                    authError = .unknownError
                }
                completionHandler(.failure(authError!))
            } else {
                completionHandler(.success(true))
            }
        }
    }
    
    
    
    
    func signOut() {
        userSession = nil
        user = nil
        try? Auth.auth().signOut()
        print("User has signed out")
    }
    
    
    
    // FETCH USER INFORMATION
    func fetchUser() {
        guard let uid = userSession?.uid else { return }

        
//        Firestore.firestore()
//            .collection("users")
        COLLECTION_USERS
            .document(uid)
            // usually no error in firebase so no need in include error just _
            .getDocument { (snapshot, _) in
                guard let data = snapshot?.data() else { return }
                self.user = User(dictionary: data)
            }
    }
    
    
    func tabTitle(forIndex index : Int) -> String {
        switch index {
        case 0: return "Home"
        case 1: return "Orders"
        case 2: return "Controls"
        case 3: return "Settings"
        default: return ""
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - SignIn with Apple Functions
    
    static func signInWithApple(idTokenString: String, nonce: String, completion: @escaping (Result<AuthDataResult, Error>) -> ()) {
        // Initialize a Firebase credential.
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: idTokenString,
                                                  rawNonce: nonce)
        // Sign in with Apple.
        Auth.auth().signIn(with: credential) { (authDataResult, err) in
            if let err = err {
                // Error. If error.code == .MissingOrInvalidNonce, make sure
                // you're sending the SHA256-hashed nonce as a hex string with
                // your request to Apple.
                print(err.localizedDescription)
                completion(.failure(err))
                return
            }
            // User is signed in to Firebase with Apple.
            guard let authDataResult = authDataResult else {
                completion(.failure(SignInWithAppleAuthError.noAuthDataResult))
                return
            }
            completion(.success(authDataResult))
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    static func handle(_ signInWithAppleResult: SignInWithAppleResult , completion: @escaping (Result<Bool, Error>) -> ()) {
        // SignInWithAppleResult is a tuple with the authDataResult and appleIDCredentioal
        // Now that you are signed in, we can update our User database to add this user.
        
        // First the uid
        let uid = signInWithAppleResult.authDataResult.user.uid
        
        // Now Extract the fullname into a single string name
        // Note, you only get this object when the account is created.
        // All subsequent times, the fullName will be nill so you need to capture it now if you want it for
        // your database
        
        var name = ""
        let fullName = signInWithAppleResult.appleIDCredential.fullName
        // Extract all three components
        let givenName = fullName?.givenName ?? ""
        let middleName = fullName?.middleName ?? ""
        let familyName = fullName?.familyName ?? ""
        let names = [givenName, middleName, familyName]
        // remove any names that are empty
        let filteredNames = names.filter {$0 != ""}
        // Join the names together into a single name
        for i in 0..<filteredNames.count {
            name += filteredNames[i]
            if i != filteredNames.count - 1 {
                name += " "
            }
        }
        
        let email = signInWithAppleResult.authDataResult.user.email ?? ""
        // CHECK IF USER EXIST
        
        // CREATE AUTHENTICATE NEW USER
//        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
//            if let error = error {
//                print("DEBUG: Error \(error.localizedDescription)")
//                return // if error - print error and stop
//            }
//
//            print("DEBUG: Successfully signup user...")
//            print("DEBUG: Email is \(email)")
//
            // CHECK IF USER EXIST
       //     guard let user = result.user else { return }
            
            // ADD TO COLLECTION IN CLOUD FIREBASE
            let data = ["email" : email,
                        "fullname" : name,
                        "uid" : uid
            ]
            // FETCH THE USER
            COLLECTION_USERS
                .document(uid)
                .setData(data) { _ in
                 //   userSession = user
               //    fetchUser() // elimiates bug on need to close app to see changes
                    print("DEBUG: Successfully uploaded user data to cloud firebase")
                }
        
//        FBFirestore.mergeFBUser(data, uid: uid) { (result) in
//                completion(result)
//
//        }
//
//       guard let user = result?.user else { return }
//
//        // ADD TO COLLECTION IN CLOUD FIREBASE
//        let data = ["email" : email,
//                    "fullname" : name,
//                    "uid" : uid
//        ]
//        // FETCH THE USER
//        COLLECTION_USERS
//            .document(user.uid)
//            .setData(data) { _ in
//                self.userSession = user
//                self.fetchUser() // elimiates bug on need to close app to see changes
//                print("DEBUG: Successfully uploaded user data to cloud firebase")
//            }
  
//        let data = User.dataDict(uid: uid,
//                                   name: name,
//                                   email: email
//        )
//
//        // Now create or merge the User in Firestore DB
//        FBFirestore.mergeFBUser(data, uid: uid) { (result) in
//            completion(result)
//        }
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    static func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if length == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    static func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Validation Checks
    
    
    // Do the passwords Match ?
    func passwordsMatch(_confirmPW:String) -> Bool {
        return _confirmPW == password
    }
    
    // Is the field Empty ?
    func isEmpty(_field:String) -> Bool {
        return _field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // Is this a valid Email address ?
    func isEmailValid(_email: String) -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return passwordTest.evaluate(with: email)
    }
    
    // Does the password meet the minimum password requirments ?
    func isPasswordValid(_password: String) -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
    // Checks that all above checks are true and returning true if so and will be used to enable or disable the signup button (REGISTER)
    var isSignInComplete:Bool  {
        if  !isEmailValid(_email: email) ||
            isEmpty(_field: fullname) ||
            !isPasswordValid(_password: password) ||
            !passwordsMatch(_confirmPW: confirmPassword){
            return false
        }
        return true
    }
    
    // Disables the login button (LOGIN) if the fields are empty
    var isLogInComplete:Bool {
        if isEmpty(_field: email) ||
            isEmpty(_field: password) {
            return false
        }
        return true
    }
    
    // MARK: - Validation Error Strings (returning errors)
    
    
    var validNameText: String {
        if !isEmpty(_field: fullname) {
            return ""
        } else {
            return "Enter your full name"
        }
    }
    
    
    var validEmailAddressText:String {
        if isEmailValid(_email: email) {
            return ""
        } else {
            return "Enter a valid email address"
        }
    }
    
    var validPasswordText:String {
        if isPasswordValid(_password: password) {
            return ""
        } else {
            return "Must be 8 characters containing at least one number and one Capital letter."
        }
    }
    
    var validConfirmPasswordText: String {
        if passwordsMatch(_confirmPW: confirmPassword) {
            return ""
        } else {
            return "Password fields do not match."
        }
    }
}

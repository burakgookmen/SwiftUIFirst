import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var isUserRegistered = false
    @State private var isLoggedIn = false
    @State private var registeredUsernames = [String]()
    @State private var registeredPasswords = [String]()
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if !isUserRegistered && !isLoggedIn {
                    signUpView
                } else if isUserRegistered && !isLoggedIn {
                    loginView
                } else if isLoggedIn {
                    homeView
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Durum"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
            }
        }
    }
    
    var signUpView: some View {
        VStack(spacing: 20) {
            Text("Üye Ol")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            TextField("Kullanıcı Adı", text: $username)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
            
            TextField("E-posta", text: $email)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField("Şifre", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
            
            Button(action: {
                if username.isEmpty || email.isEmpty || password.isEmpty {
                    alertMessage = "Lütfen tüm alanları doldurun."
                    showAlert.toggle()
                } else {
                    registeredUsernames.append(username)
                    registeredPasswords.append(password)
                    isUserRegistered = true
                    alertMessage = "Üyeliğiniz başarıyla oluşturuldu! Lütfen giriş yapın."
                    showAlert.toggle()
                }
            }) {
                Text("Üye Ol")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(15)
                    .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 5)
                    .padding(.horizontal)
            }
        }
        .padding(.top, 40)
    }
    
    var loginView: some View {
        VStack(spacing: 20) {
            Text("Giriş Yap")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            TextField("Kullanıcı Adı", text: $username)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
            
            SecureField("Şifre", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
            
            Button(action: {
                if username.isEmpty || password.isEmpty {
                    alertMessage = "Lütfen tüm alanları doldurun."
                    showAlert.toggle()
                } else if !registeredUsernames.contains(username) || !registeredPasswords.contains(password) {
                    alertMessage = "Geçersiz kullanıcı adı veya şifre."
                    showAlert.toggle()
                } else {
                    isLoggedIn = true
                    alertMessage = "Giriş başarılı!"
                    showAlert.toggle()
                }
            }) {
                Text("Giriş Yap")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(15)
                    .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 5)
                    .padding(.horizontal)
            }
        }
        .padding(.top, 40)
    }

    var homeView: some View {
        VStack {
            Text("Hoş geldiniz, \(username)!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding()
            
            Image(systemName: "app.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .padding()
            
            Text("!")
                .font(.title2)
                .padding()
            
            Button(action: {
                isLoggedIn = false
                username = ""
                password = ""
                alertMessage = "Çıkış yapıldı!"
                showAlert.toggle()
            }) {
                Text("Çıkış Yap")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.red, lineWidth: 2)
                    )
                    .shadow(color: Color.red.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.horizontal)
            }
        }
        .padding(.top, 40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

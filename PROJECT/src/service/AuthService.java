package service;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;
import util.SessionManager;

public class AuthService {
    private final UserDAO userDAO = new UserDAO();

    public boolean register(String username, String password, String email, String fullName) {
        if (userDAO.isUsernameExists(username)) {
            System.out.println("Ten tai khoan da ton tai!");
            return false;
        }
        if (userDAO.isEmailExists(email)) {
            System.out.println("Email da ton tai!");
            return false;
        }

        String hashedPassword = PasswordUtil.hashPassword(password);
        User user = new User(username, hashedPassword, email, fullName, "CUSTOMER");

        return userDAO.registerUser(user);
    }

    public boolean login(String username, String password) {
        User user = userDAO.getUserByUsername(username);
        if (user == null) {
            System.out.println("Tai khoan khong ton tai!");
            return false;
        }

        String hashedPassword = PasswordUtil.hashPassword(password);
        if (user.getPassword().equals(hashedPassword)) {
            SessionManager.setCurrentUser(user);
            return true;
        } else {
            System.out.println("Mat khau khong chinh xac!");
            return false;
        }
    }

    public void logout() {
        SessionManager.clearSession();
        System.out.println("Da dang xuat thanh cong!");
    }
}

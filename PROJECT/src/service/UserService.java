package service;

import dao.UserDAO;
import model.User;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    public User getUserProfile(String username) {
        return userDAO.getUserByUsername(username);
    }
}

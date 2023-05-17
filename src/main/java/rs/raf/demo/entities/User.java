package rs.raf.demo.entities;

public class User {
    private String username;
    private String role;
    private String hashedPassword;

    public User() {
    }

    public User(String username, String role, String hashedPassword) {
        this.username = username;
        this.role = role;
        this.hashedPassword = hashedPassword;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getHashedPassword() {
        return hashedPassword;
    }

    public void setHashedPassword(String hashedPassword) {
        this.hashedPassword = hashedPassword;
    }
}


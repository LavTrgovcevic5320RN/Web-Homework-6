package rs.raf.demo.repositories.user;

import rs.raf.demo.entities.Post;
import rs.raf.demo.entities.User;
import rs.raf.demo.repositories.MySqlAbstractRepository;

import java.sql.*;

public class MySqlUserRepository extends MySqlAbstractRepository implements UserRepository {

    public MySqlUserRepository() {
        User user1 = new User("lav", "admin", "e9138f38d979c81ca528a9a73cbd90892f7413496b076bc655ecc937325369a4"); // lav
        User user2 = new User("pera", "korisnik", "ae0a456b0a5b5a05196cf4e6392e597b5a4e99545c6a5254f5ddca6ae6d016a1"); // pera

        addUser(user1);
        addUser(user2);
    }

    private void addUser(User user){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = this.newConnection();

            String[] generatedColumns = {"id"};

            preparedStatement = connection.prepareStatement("INSERT INTO posts (title, author, content, createdDate) VALUES(?, ?, ?, ?)", generatedColumns);
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getRole());
            preparedStatement.setString(3, user.getHashedPassword());

            preparedStatement.executeUpdate();
            resultSet = preparedStatement.getGeneratedKeys();

//            if (resultSet.next()) {
//                post.setId(resultSet.getInt(1));
//            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(preparedStatement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }
    }

    @Override
    public User findUser(String username) {
        User user = null;

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("SELECT * FROM posts where username = ?");
            preparedStatement.setString(1, username);
            resultSet = preparedStatement.executeQuery();

            if(resultSet.next()) {
                String userId = resultSet.getString("username");
                String role = resultSet.getString("role");
                String hashedPassword = resultSet.getString("hashedPassword");
                user = new User(userId, role, hashedPassword);
            }

            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(preparedStatement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }

        return user;
    }
}

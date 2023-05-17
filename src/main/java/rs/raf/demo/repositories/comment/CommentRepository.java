package rs.raf.demo.repositories.comment;

import rs.raf.demo.entities.Comment;

import java.util.List;

public interface CommentRepository {

    public Comment addComment(Integer id, Comment comment);
    public List<Comment> allComments(Integer id);
    public Comment findComment(Integer id);
    public void deleteComment(Integer id);
}

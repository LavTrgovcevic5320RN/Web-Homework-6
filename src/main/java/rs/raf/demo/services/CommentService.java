package rs.raf.demo.services;

import rs.raf.demo.entities.Comment;
import rs.raf.demo.repositories.comment.CommentRepository;

import javax.inject.Inject;
import java.util.List;

public class CommentService {

    public CommentService() {
        System.out.println(this);
    }

    @Inject
    private CommentRepository commentRepository;

    public Comment addComment(Integer id, Comment comment) {
        return this.commentRepository.addComment(id, comment);
    }

    public List<Comment> allComment(Integer id) {
        return this.commentRepository.allComments(id);
    }

    /*
    public Comment findComment(Integer id) {
         return this.commentRepository.findSubject(id);
     }

     public void deleteComment(Integer id) {
         this.commentRepository.deleteSubject(id);
     }
    */
}

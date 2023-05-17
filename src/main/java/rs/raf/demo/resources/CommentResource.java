package rs.raf.demo.resources;

import rs.raf.demo.entities.Comment;
import rs.raf.demo.services.CommentService;

import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("/comments")
public class CommentResource {

    @Inject
    private CommentService commentService;

    /*@GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response all() {
        return Response.ok(this.commentService.allComment()).build();
    }
    */

    @POST
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Comment create(@PathParam("id") Integer id, @Valid Comment comment) {
        return this.commentService.addComment(id, comment);
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Comment> getComments(@PathParam("id") Integer id) {
        //System.out.println(id);
        return this.commentService.allComment(id);
    }

    /*@DELETE
    @Path("/{id}")
    public void delete(@PathParam("id") Integer id) {
        this.commentService.deleteComment(id);
    }*/

}

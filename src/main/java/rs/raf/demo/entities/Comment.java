package rs.raf.demo.entities;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

public class Comment {

    private Integer id;

    private Integer postID;

    @NotNull(message = "This field is required")
    @NotEmpty(message = "This field is required")
    private String name;

    @NotNull(message = "This field is required")
    @NotEmpty(message = "This field is required")
    private String content;

    public Comment() {
    }

    public Comment(Integer postID, String name, String content) {
        this();
        this.postID = postID;
        this.name = name;
        this.content = content;
    }

    public Comment(Integer id, Integer postID, String name, String content) {
        this(postID, name, content);
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPostID() {
        return postID;
    }

    public void setPostID(Integer postID) {
        this.postID = postID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}

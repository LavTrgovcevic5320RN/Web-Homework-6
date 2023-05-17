package rs.raf.demo.entities;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Date;

public class Post {

    private Integer id;

    @NotNull(message = "This field is required")
    @NotEmpty(message = "This field is required")
    private String title;

    @NotNull(message = "This field is required")
    @NotEmpty(message = "This field is required")
    private String date;

    @NotNull(message = "This field is required")
    @NotEmpty(message = "This field is required")
    private String name;

    @NotNull(message = "This field is required")
    @NotEmpty(message = "This field is required")
    private String content;

    public Post() {
    }

    public Post(String title, String date, String name, String content) {
        this();
        this.title = title;
        this.date = date;
        this.name = name;
        this.content = content;
    }

    public Post(Integer id, String title, String date, String name, String content) {
        this(title, date, name, content);
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
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


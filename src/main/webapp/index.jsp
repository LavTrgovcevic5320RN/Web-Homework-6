<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Public Blog</title>
    <%@ include file="styles.jsp" %>
</head>
<body>


<div class="container" id="main">
    <div id="posts">
        <h1 class="naslov">Posts</h1>
        <hr>
    </div>
    <button class="btn btn-primary" id="newPostBtn">New Post</button>

    <h2 id="newPostLabel"><b>New post</b></h2>
    <form method="POST" id="postForm">
        <div class="form-group">
            <label for="postAuthorForm">Author</label>
            <input type="text" class="form-control" name="postAuthor" id="postAuthorForm" placeholder="Enter name">
        </div>
        <div class="form-group">
            <label for="postTitleForm">Title</label>
            <input type="text" class="form-control" name="postTitle" id="postTitleForm" placeholder="Enter title">
        </div>
        <div class="form-group">
            <label for="postContentForm">Content</label>
            <input type="text" class="form-control" name="postContent" id="postContentForm" placeholder="Enter post content">
        </div>
        <button type="submit" class="btn btn-primary">Save Post</button>
    </form>

    <div id="singlePost">
        <h2 id="postTitle" style="font-weight: bold"></h2>
        <h6 id="postDate"></h6>
        <h6 id="postAuthor"></h6>
        <p id="postContent"></p>
    </div>

    <br>
    <div class="row" id="postComments">
        <div class="col">
            <h2>Comments</h2>
            <div id="comments"></div>
            <hr>
            <br>
            <h5>New Comment</h5>
            <form method="POST" id="commentForm">
                <div class="form-group">
                    <label for="commentNameForm">Name</label>
                    <input type="text" class="form-control" name="commentName" id="commentNameForm" placeholder="Enter name">
                </div>
                <div class="form-group">
                    <label for="commentBodyForm">Comment</label>
                    <input type="text" class="form-control" name="commentBody" id="commentBodyForm" placeholder="Enter comment">
                </div>
                <button type="submit" class="btn btn-primary">Comment</button>
            </form>
            <button class="btn btn-primary" id="backBtn">Back</button>
        </div>
    </div>
</div>

<script>

    const postsView = document.getElementById("posts");
    const newPostBtnView = document.getElementById("newPostBtn");
    const newPostLabelView = document.getElementById("newPostLabel");
    const newPostView = document.getElementById("postForm");
    const singlePostView = document.getElementById("singlePost");
    const singlePostCommentsView = document.getElementById("postComments");

    showPostsView();

    fetch('/api/posts', {
        method: 'GET'
    }).then(response => {
        return response.json();
    }).then(posts => {
        for (const post of posts) {
            addPostElements(post)
        }
    })

    newPostBtnView.addEventListener('click', function(e) {
        showNewPostView();
    })

    function addPostElements(post) {
        const postLinks = document.getElementById('posts');

        const linkWrapperDiv = document.createElement('div');
        linkWrapperDiv.addEventListener("click", function() {
            singlePost(post.id);
            showSinglePostView();
        });

        const postAuthor = document.createElement('h2');
        postAuthor.innerText = post.name;

        const postTitle = document.createElement('h5');
        postTitle.innerText = post.title;

        const postContent = document.createElement("p");
        postContent.innerText = post.content;

        const postDetails = document.createElement('a');
        postDetails.innerText = "Opširnije";
        postDetails.addEventListener("click", function() {
            singlePost(post.id);
        });

        linkWrapperDiv.appendChild(postAuthor);
        linkWrapperDiv.appendChild(postTitle);
        linkWrapperDiv.appendChild(postContent);
        linkWrapperDiv.appendChild(postDetails);
        linkWrapperDiv.appendChild(document.createElement('hr'));

        postLinks.appendChild(linkWrapperDiv);
    }

    document.getElementById("postForm").addEventListener('submit', function(e) {
        e.preventDefault();

        const postAuthorElement = document.getElementById('postAuthorForm');
        const postTitleElement = document.getElementById('postTitleForm');
        const postContentElement = document.getElementById('postContentForm');

        const name = postAuthorElement.value;
        const title = postTitleElement.value;
        const content = postContentElement.value;
        let date1 = new Date()
        let day = String(date1.getDate()).padStart(2, '0');
        let month = String(date1.getMonth()+1).padStart(2, "0");
        let year = date1.getFullYear();

        //let date = day + "." + month + "." + year + ".";
        let date = year + "-" + month + "-" + day;

        fetch('/api/posts', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                title: title,
                name: name,
                content: content,
                date: date
            }),
        }).then(response => {
            console.log('Response:', response)
            return response.json();
        }).then(post => {
            addPostElements(post);
            showPostsView();
            postAuthorElement.value = '';
            postTitleElement.value = '';
            postContentElement.value = '';
        })
    })

    let ID;
    function singlePost(id){
        fetch('/api/posts/' + id, {
            method: 'GET'
        }).then(response => {
            return response.json();
        }).then(post => {
            ID = id;
            addSinglePostElements(post);
        })
    }

    function addSinglePostElements(post) {
        const singlePostLinks = document.getElementById('singlePost');

        const linkWrapperDiv = document.createElement('div');

        const postTitle = document.getElementById("postTitle");
        const postDate = document.getElementById("postDate");
        const postAuthor = document.getElementById("postAuthor");
        const postContent = document.getElementById("postContent");

        postTitle.innerText = post.title;
        postDate.innerText = post.date;
        postAuthor.innerText = post.name;
        postContent.innerText = post.content;

        document.getElementById("comments").innerHTML = '';

        fetch('/api/comments/' + post.id, {
            method: 'GET'
        }).then(response => {
            return response.json();
        }).then(comments => {
            for (const comment of comments) {
                addPostComment(comment);
            }
        })

        linkWrapperDiv.appendChild(postTitle);
        linkWrapperDiv.appendChild(postDate);
        linkWrapperDiv.appendChild(postAuthor);
        linkWrapperDiv.appendChild(postContent);
        singlePostLinks.appendChild(linkWrapperDiv);


    }

    document.getElementById("commentForm").addEventListener('submit', function(e) {
        e.preventDefault();

        const commentAuthorElement = document.getElementById('commentNameForm');
        const commentContentElement = document.getElementById('commentBodyForm');

        const name = commentAuthorElement.value;
        const content = commentContentElement.value;

        fetch('/api/comments/'+ ID, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                postID: ID,
                name: name,
                content: content
            }),
        }).then(response => {
            console.log('Response:', response)
            return response.json();
        }).then(comment => {
            addPostComment(comment);
            commentAuthorElement.value = '';
            commentContentElement.value = '';
        })
    })


    function addPostComment(comment) {
        const comments = document.getElementById('comments');

        const linkWrapperDiv = document.createElement('div');

        const commentAuthor = document.createElement('h2');
        commentAuthor.innerText = comment.name;

        const commentContent = document.createElement('h5');
        commentContent.innerText = comment.content;

        linkWrapperDiv.appendChild(document.createElement('hr'));
        linkWrapperDiv.appendChild(commentAuthor);
        linkWrapperDiv.appendChild(commentContent);
        linkWrapperDiv.appendChild(document.createElement('hr'));

        comments.appendChild(linkWrapperDiv);
    }

    document.getElementById("backBtn").addEventListener('click', function(e) {
        showPostsView();
    })

    function showPostsView() {
        postsView.style.display = "block";
        newPostBtnView.style.display = "block";
        newPostLabelView.style.display = "none";
        newPostView.style.display = "none";
        singlePostView.style.display = "none";
        singlePostCommentsView.style.display = "none";
    }

    function showNewPostView(){
        postsView.style.display = "none";
        newPostBtnView.style.display = "none";
        newPostLabelView.style.display = "block";
        newPostView.style.display = "block";
        singlePostView.style.display = "none";
        singlePostCommentsView.style.display = "none";
    }

    function showSinglePostView(){
        postsView.style.display = "none";
        newPostBtnView.style.display = "none";
        newPostLabelView.style.display = "none";
        newPostView.style.display = "none";
        singlePostView.style.display = "block";
        singlePostCommentsView.style.display = "block";
    }

</script>
</body>
</html>

<template>
  <div>
    <div v-if="error">{{ error }}</div>
    <h3>Add a new blog</h3>

    <form @submit.prevent="addBlog" >
      <div>
        <label for="blog_title" class="label">Title</label>
        <input
          type="string"
          id="blog_title"
          class="input"
          autofocus
          autocomplete="off"
          placeholder="Type a blog title"
          v-model="newBlog.title">
      </div>

      <div>
        <label for="blog_body" class="label">Body</label>
        <input
          type="text"
          id="blog_body"
          class="input"
          autofocus
          autocomplete="off"
          placeholder="Body"
          v-model="newBlog.body">
      </div>

      <input type="submit" value="Add Blog">
    </form>

    <hr />

    <ul>
      <li v-for="blog in blogs" :key="blog.id" :blog="blog">
        <div>
          <div>
            <p>
              {{ blog.title }} &mdash; {{ blog.body }}
            </p>
          </div>

          <button @click.prevent="editBlog(blog)">Edit</button>

          <button @click.prevent="removeBlog(blog)">Delete</button>
        </div>

        <div v-if="blog == editedBlog">
          <form action="" @submit.prevent="updateBlog(blog)">
            <div>

              <div>
                <label class="label">Title</label>
                <input class="input" v-model="blog.title">
              </div>

              <div>
                <label class="label">Body</label>
                <input class="input" v-model="blog.body">
              </div>

              <input type="submit" value="Update">
            </div>
          </form>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Blogs',
  data () {
    return {
      blogs: [],
      newBlog: [],
      error: '',
      editedBlog: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/blogs')
        .then(response => { this.blogs = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addBlog () {
      const value = this.newBlog
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/blogs/', { blog: {title: this.newBlog.title, body: this.newBlog.body} })
        .then(response => {
          this.blogs.push(response.data)
          this.newBlog = ''
        })
        .catch(error => this.setError(error, 'Cannot create blog'))
    },
    removeBlog (blog) {
      this.$http.secured.delete(`/api/v1/blogs/${blog.id}`)
        .then(response => {
          this.blogs.splice(this.blogs.indexOf(blog), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete blog'))
    },
    editBlog (blog) {
      this.editedBlog = blog
    },
    updateBlog (blog) {
      this.editedBlog = ''
      this.$http.secured.patch(`/api/v1/blogs/${blog.id}`, { blog: { title: blog.title, body: blog.body } })
        .catch(error => this.setError(error, 'Cannot update blog'))
    }
  }
}
</script>

<style scoped>
button,
a {
  text-decoration: none;
  padding: 0.75rem 1.5rem;
  font: inherit;
  background-color: #3a0061;
  border: 1px solid #3a0061;
  color: white;
  cursor: pointer;
  border-radius: 30px;
  margin-right: 0.5rem;
  display: inline-block;
}

a:hover,
a:active,
button:hover,
button:active {
  background-color: #270041;
  border-color: #270041;
}
ul {
  list-style: none;
  margin: 0;
  padding: 0;
}

.controls {
  display: flex;
  justify-content: space-between;
}
</style>

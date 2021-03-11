<template>
<div>
    <Header />
  <div class="max-w-4xl m-auto py-5">
  <!-- <div style="width:56rem;"> -->
    <div v-if="error">{{ error }}</div>
    <!-- <h3>Add a new blog</h3> -->

    <!-- <b-link to="/new" variant="primary">Add new Blog</b-link> -->
    <b-button @click.prevent="addBlog" variant="primary">Add new Blog</b-button>

    <hr />

    <ul>
      <li v-for="blog in blogs" :key="blog.id" :blog="blog">
        <b-card bg-variant="light" text-variant="white" style="width: 56rem;">
            <b-link  @click.prevent="showBlog(blog.id)">{{ blog.title }}</b-link>
            <b-card-text class="text-dark">
              {{ blog.body }}
            </b-card-text>

          <b-button v-on:click.self.prevent="editBlog(blog.id)" variant="outline-primary" v-if="checkValidation(blog.user_id)">Edit</b-button>
          <b-button v-on:click.self.prevent="removeBlog(blog.id)" variant="outline-secondary" v-if="checkValidation(blog.user_id)">Delete</b-button>
        </b-card>
        <br>
      </li>
    </ul>
  </div>
  </div>
</template>

<script>
import Header from '@/components/Header.vue'
// import Header from '../Header.vue'
export default {
  name: 'Blogs',
  components: {
    Header
    // Header
  },
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
      this.$http.secured
        .get('/api/v2/blogs')
        .then(response => {
          this.blogs = response.data
        })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        text
    },
    addBlog () {
      this.$router.replace('/new')
      // const value = this.newBlog
      // if (!value) {
      //   return
      // }
      // this.$http.secured
      //   .post('/api/v2/blogs/', {
      //     blog: { title: this.newBlog.title, body: this.newBlog.body }
      //   })
      //   .then(response => {
      //     this.blogs.push(response.data)
      //     this.newBlog = ''
      //   })
      //   .catch(error => this.setError(error, 'Cannot create blog'))
    },
    removeBlog (blog) {
      this.$http.secured
        .delete(`/api/v2/blogs/${blog.id}`)
        .then(response => {
          this.blogs.splice(this.blogs.indexOf(blog), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete blog'))
    },
    showBlog (blog) {
      this.$router.replace('/show/' + blog)
    },
    editBlog (blog) {
      this.$router.push('/edit/' + blog)
    },
    updateBlog (blog) {
      this.editedBlog = ''
      this.$http.secured
        .patch(`/api/v2/blogs/${blog.id}`, {
          blog: { title: blog.title, body: blog.body }
        })
        .catch(error => this.setError(error, 'Cannot update blog'))
    },
    checkValidation (id) {
      // debugger
      if (parseInt(localStorage.userId) === id) {
        return true
      } else {
        return false
      }
    }
  }
}
</script>

<style scoped>
/* .card {
  position: relative;
}

a.stretched-link:before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
}

.second {
  required
  position: relative;
  z-index: 1;
} */
</style>

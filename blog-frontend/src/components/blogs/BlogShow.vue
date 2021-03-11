<template>
  <div>
    <Header />
    <div class="max-w-md m-auto py-10">
      <div class="text-red" v-if="error">
        {{ error }}
      </div>
      <h3 class="font-mono font-regular text-3xl mb-4">Blog</h3>
      <div id="mb-6">
        <h2>Title: {{ newBlog.title}} </h2>
      </div>
      <div id="mb-6">
        <h3>Body: {{ newBlog.body }} </h3>
      </div>
      <b-button @click.prevent="editBlog(newBlog.id)" variant="outline-primary" v-if="checkValidation(newBlog.user_id)">Edit</b-button>
      <b-button @click.prevent="removeBlog(newBlog.id)" variant="outline-secondary" v-if="checkValidation(newBlog.user_id)">Delete</b-button>
      <hr/>
      <b-form action="" @submit.prevent="addComment">
        <div class="mb-6">
          <b-textarea
            class="input"
            autofocus
            autocomplete="off"
            placeholder="Post a Comment"
            id="body"
            v-model="newComment.body"
          />
        </div>
        <b-button type="submit" variant="success" block>Comment</b-button>
      </b-form>
      <hr/>
      <h3>Comments</h3>
      <ul>
      <li class="list-group-item" v-for="comment in comments" :key="comment.id">
        <p>{{ comment.uname }}</p>
        <p>{{ comment.body }}</p>
      </li>
      </ul>
      <br/>

      <br />
      <button class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-red hover:bg-red-dark block w-full py-4 text-white items-center justify-center"
        @click="back">Back</button>
    </div>
  </div>
</template>

<script>
import Header from '@/components/Header.vue'
export default {
  name: 'Blogs',
  components: {
    Header
  },
  data () {
    return {
      newBlog: [],
      newComment: [],
      comments: [],
      error: ''
    }
  },

  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('api/v2/blogs/' + this.$route.params.id)
        .then(response => {
          this.newBlog = response.data
        })
        .catch(function (error) {
          console.log(error)
        })
      this.$http.secured.get('api/v2/blogs/' + this.$route.params.id + '/comments')
        .then(response => {
          this.comments = response.data
        })
        .catch(function (error) {
          console.log(error)
        })
    }
  },

  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },

    addComment () {
      const value = this.newComment
      if (!value) {
        return
      }
      this.$http.secured
        .post('api/v2/blogs/' + this.$route.params.id + '/comments', {
          comment: {
            body: this.newComment.body,
            blog_id: this.$route.params.id
          }
        })
        .then(response => {
          this.newComment.body = ''
          this.userName()
        })
        .catch(error => this.setError(error, 'Cannot create comment'))
    },
    checkValidation (id) {
      // debugger
      if (parseInt(localStorage.userId) === id) {
        return true
      } else {
        return false
      }
    },
    userName () {
      this.$http.secured
        .get('api/v2/blogs/' + this.$route.params.id + '/comments')
        .then(response => {
          this.comments = response.data
        })
        .catch(error => console.log(error))
    },
    removeBlog (newBlog) {
      this.$http.secured
        .delete(`/api/v2/blogs/${newBlog}`)
        .then(response => {
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot delete blog'))
    },
    editBlog (newBlog) {
      this.$router.push('/edit/' + newBlog)
    },
    back () {
      this.$router.replace('/blogs')
    }
  }
}
</script>

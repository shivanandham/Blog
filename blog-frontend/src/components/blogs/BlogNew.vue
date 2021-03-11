<template>
      <!-- <div class="mb-6">
        <textarea class="input"
          autofocus autocomplete="off"
          placeholder="Body"
          v-model="newBlog.body" />
      </div> -->
      <!-- <div class="mb-6">
        <input class="input"
          autofocus autocomplete="off"
          placeholder="Title"
          v-model="newBlog.title" />

      </div> -->
      <div>

  <Header />
<div class="bg">
  <div class="container">
    <div class="col new-sec">

    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="text-center">Add New Blog</h3>
    <form action="" @submit.prevent="addBlog">
      <b-form-group id="title" label="Title" label-for="title">
        <b-form-input
          id="title"
          v-model="newBlog.title"
          placeholder="Enter Title"
          required
          class="form-control"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="body" label="Body" label-for="body">
        <b-textarea
          id="bodyy"
          v-model="newBlog.body"
          placeholder="Enter Content"
          required
          class="form-control"
        ></b-textarea>
      </b-form-group>
      <b-button class="btnNewSubmit" block type="submit" value="Save">Save</b-button>
      <br>
    <b-button variant="outline-primary" class="container" style="width:10%;" @click="back">Back</b-button>
    </form>
    </div>
  </div>
      </div>
</div>

<!-- <div class="container contact-form">
  <form action="" @submit.prevent="addBlog">
      <h3>Add New Blog</h3>
      <div class="row">
          <div class="col-md-6">
              <div class="form-group">
                  <input type="text" name="txtName" class="form-control" placeholder="Enter Title *" v-model="newBlog.title" />
              </div>
               <div class="form-group">
                  <input type="text" name="txtEmail" class="form-control" placeholder="Your Email *" value="" />
              </div>
              <div class="form-group">
                  <input type="text" name="txtPhone" class="form-control" placeholder="Your Phone Number *" value="" />
              </div>
              <div class="form-group">
                  <input type="submit" name="btnSubmit" class="btnContact" value="Send Message" />
              </div>
          </div>
          <div class="col-md-6">
              <div class="form-group">
                  <textarea name="txtMsg" class="form-control" placeholder="Your Message *" style="width: 100%; height: 150px;"></textarea>
              </div>
          </div>
      </div>
  </form>
</div> -->
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
      error: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
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
      this.$http.secured.post('/api/v2/blogs/', { blog: { title: this.newBlog.title, body: this.newBlog.body } })

        .then(response => {
          this.newBlog = ''
          this.$router.replace('/blogs')
        })
        .catch(error => this.setError(error, 'Cannot create blog'))
    },
    back () {
      this.$router.replace('/blogs')
    }
  }
}
</script>

<style scoped>

/*
.container .form-control{
    border-radius:1rem;
}
.container form{
    padding: 10%;
}
 .container h3{
    margin-bottom: 1%;
    margin-top: 10%;
    text-align: center;
    color: #0062cc;
} */
.btnNewSubmit
{
    width: 100%;
    border-radius: 1rem;
    padding: 1.5%;
    color: #fff;
    background-color: #0062cc;
    border: none;
    cursor: pointer;
}
.bg{
  float: left;
  width: 100%;
  padding: 229px 200px;
  background-image: url('../../assets/new.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: fill;
}
.container {
  background: #fff;
  border-radius: 10px;
  width: 50%;
}
.new-sec h3 {
  margin-bottom: 30px;
  font-weight: 800;
  font-size: 30px;
  color: #0069c0;
}
.new-sec {
  padding: 50px 30px;
  position: relative;
}
</style>
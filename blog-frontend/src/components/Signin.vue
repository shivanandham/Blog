<template>
  <!-- <div>
    <div class="border p-10 border-grey-light shadow rounded">
      <h3 class="text-2xl mb-6 text-grey-darkest">Sign In</h3>
      <b-form @submit.prevent="signin">
        <div class="text-red" v-if="error">{{ error }}</div>

        <b-form-group label="Username" label-for="email">
          <b-form-input id="email" v-model="email" type="email" placeholder="Enter Email Address" required></b-form-input>
        </b-form-group>

        <b-form-group label="Password" label-for="password">
          <b-form-input id="password" v-model="password" type="password" placeholder="Password" required></b-form-input>
        </b-form-group>

        <b-button type="submit" variant="primary" >Sign In</b-button>

        <b-link to="/signup" class="link-grey" variant="outline-primary">Sign up</b-link>
      </b-form>
    </div>
  </div> -->

  <section class="login-block">
    <div class="container">
      <div class="row ">
        <div class="col login-sec">
          <h2 class="text-center">Login </h2>
          <b-form @submit.prevent="signin">
            <div class="text-red" v-if="error">{{ error }}</div>

            <b-form-group
              label="Username"
              label-for="email"
            >
              <b-form-input
                id="email"
                v-model="email"
                type="email"
                placeholder="Enter Email Address"
                required
              ></b-form-input>
            </b-form-group>

            <b-form-group
              label="Password"
              label-for="password"
            >
              <b-form-input
                id="password"
                v-model="password"
                type="password"
                placeholder="Password"
                required
              ></b-form-input>
            </b-form-group>

            <b-button type="submit" variant="primary">Sign In</b-button>

            <b-link to="/signup" class="link-grey" variant="outline-primary"
              >Sign Up</b-link
            >
          </b-form>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'Signin',
  data () {
    return {
      email: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signin () {
      this.$http.plain.post('/signin', { email: this.email, password: this.password })
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      // debugger
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      // console.log(typeof(userId))
      // console.log(typeof(response.data.userId.id))
      localStorage.userId = response.data.userId.id
      localStorage.signedIn = true

      this.$store.commit('setUser', {
        token: true
      })
      this.error = ''
      this.$router.replace('/blogs')
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
      delete localStorage.userId
      this.$store.commit('setUser', {
        token: false
      })
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/blogs')
      }
    }
  }
}
</script>

<style scoped>
.login-block {
  float: left;
  width: 100%;
  padding: 290px 200px;
  background-image: url("../assets/login.jpg");
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: cover;
}

.container {
  background: #fafafa;
  border-radius: 10px;
  width: 35%;
  height: 40%;
}
.login-sec {
  padding: 50px 30px;
  position: relative;
}
.login-sec h2 {
  margin-bottom: 30px;
  font-weight: 800;
  font-size: 30px;
  color: #0069c0;
}
.login-sec h2:after {
  content: " ";
  width: 90px;
  height: 5px;
  background: #080146;
  display: block;
  margin-top: 20px;
  border-radius: 3px;
  margin-left: auto;
  margin-right: auto;
}
</style>

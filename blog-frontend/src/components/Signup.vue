<template>
  <!-- <div class="max-w-sm m-auto my-8">
    <div class="border p-10 border-grey-light shadow rounded">
      <h3 class="text-2xl mb-6 text-grey-darkest">Sign Up</h3>
      <form @submit.prevent="signup">
        <div class="text-red" v-if="error">{{ error }}</div>

        <div class="mb-6">
          <label for="email" class="label">E-mail Address</label>
          <input type="email" v-model="email" class="input" id="email" placeholder="example@example.com">
        </div>

        <div class="mb-6">
          <label for="password" class="label">Password</label>
          <input type="password" v-model="password" class="input" id="password" placeholder="Password">
        </div>

        <div class="mb-6">
          <label for="password_confirmation" class="label">Password Confirmation</label>
          <input type="password" v-model="password_confirmation" class="input" id="password_confirmation" placeholder="Password Confirmation">
        </div>
        <button type="submit" >Sign Up</button>
         <button type="submit" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green hover:bg-green-dark block w-full py-4 text-white items-center justify-center">Sign Up</button>

        <div class="my-4"><router-link to="/" class="link-grey">Sign In</router-link></div>
      </form>
    </div>
  </div>  -->

  <section class="login-block">
    <div class="container">
      <div class="row ">
        <div class="col login-sec">
          <h2 class="text-center">Register </h2>
          <b-form @submit.prevent="signup">
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
              <br>
              <b-form-input
                id="password_confirmation"
                v-model="password_confirmation"
                type="password"
                placeholder="Password Confirmation"
                required
              ></b-form-input>
            </b-form-group>

            <b-button type="submit" variant="primary">Sign Up</b-button>

            <b-link to="/" class="link-grey" variant="outline-primary"
              >Sign In</b-link
            >
          </b-form>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'Signup',
  data () {
    return {
      email: '',
      password: '',
      password_confirmation: '',
      error: ''
    }
  },
  created () {
    this.checkedSignedIn()
  },
  updated () {
    this.checkedSignedIn()
  },
  methods: {
    signup () {
      this.$http.plain.post('/signup', { email: this.email, password: this.password, password_confirmation: this.password_confirmation })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/blogs')
    },
    signupFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkedSignedIn () {
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
  padding: 259px 200px;
  background-image: url("../assets/signup.jpg");
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
  width: 120px;
  height: 5px;
  background: #080146;
  display: block;
  margin-top: 20px;
  border-radius: 3px;
  margin-left: auto;
  margin-right: auto;
}
</style>

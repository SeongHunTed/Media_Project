<template>
    <div>
        <form @submit.prevent="logIn">
            <label for="username">USER NAME : </label>
            <input type="text" id="username" v-model="username"> 
            <hr>
            <label for="password">PASSWORD : </label>
            <input type="password" id="password" v-model="password">
            <hr>
            <div>
                <input style="width: 100px; height: 35px; border: 0px; background-color: lightgray; border-radius: 10px; color:black" type="submit" value="LogIn">
                <!-- <router-link :to="{ name: 'SignUpView' }"><button style="width: 100px; height: 35px; border: 0px; background-color: lightgray; border-radius: 10px; color:black">회원가입</button></router-link> -->
            </div>
        </form>
    </div>
</template>

<script>


export default {
    name: 'LogInView',
    data() {
        return {
            username: '',
            password: '',
        }
    },
    methods: {
        logIn() {
            const username = this.username
            const password = this.password

        const payload = {
            username, password
        }

        this.$store.dispatch('logIn', payload)
        }
    }
}

</script>

<style>

</style>
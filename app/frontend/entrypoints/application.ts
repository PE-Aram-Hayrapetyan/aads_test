import { createApp } from 'vue'
import App from '../pages/App.vue'

// createApp(App).mount('#app')

document.addEventListener('DOMContentLoaded', () => {
    const appElement = document.getElementById('app')
    const userData = JSON.parse(appElement.getAttribute('data-user'))

    createApp(App, {
        user: userData
    }).mount(appElement)
})
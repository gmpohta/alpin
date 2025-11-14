<template>
    <div class="vue-counter">
        <h3>Vue Counter Component</h3>
        <p>Count: {{ count }}</p>
        <button @click="increment" class="btn btn-primary">Increment</button>
        <button @click="decrement" class="btn btn-secondary">Decrement</button>
        <button @click="reset" class="btn btn-outline">Reset</button>
        
        <div class="mt-3">
            <input v-model="message" placeholder="Type something..." class="form-control">
            <p>Message: {{ message }}</p>
        </div>
    </div>
</template>

<script>
import { ref } from 'vue';

export default {
    name: 'Counter',
    setup() {
        const count = ref(0);
        const message = ref('Hello from Vue!');
        
        const increment = () => {
            count.value++;
        };
        
        const decrement = () => {
            count.value--;
        };
        
        const reset = () => {
            count.value = 0;
            message.value = 'Reset!';
        };
        
        return {
            count,
            message,
            increment,
            decrement,
            reset
        };
    }
}
</script>

<style scoped>
.vue-counter {
    border: 2px solid #42b883;
    border-radius: 8px;
    padding: 20px;
    margin: 20px 0;
    background: #f8f9fa;
}

.btn {
    padding: 8px 16px;
    margin: 0 5px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.btn-primary {
    background: #42b883;
    color: white;
}

.btn-secondary {
    background: #35495e;
    color: white;
}

.btn-outline {
    background: transparent;
    border: 1px solid #42b883;
    color: #42b883;
}

.form-control {
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    width: 200px;
}
</style>
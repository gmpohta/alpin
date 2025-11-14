import 'core-js/stable';
import { createApp } from 'vue';

const vueApps = document.querySelectorAll('[data-vue-app]');

vueApps.forEach(element => {
    const appName = element.getAttribute('data-vue-app');

    const loadComponent = async () => {
        try {
            const component = await import(`./vue/components/${appName}.vue`);
            createApp(component.default).mount(element);
        } catch (error) {
            console.error(`Failed to load Vue component: ${appName}`, error);
            element.innerHTML = `
                <div style="color: red; padding: 20px; border: 2px solid red;">
                    Error loading component: ${appName}
                    <br><small>${error.message}</small>
                </div>
            `;
        }
    };
    
    loadComponent();
});
<template>
    <div class="user-list">
        <h3>👥 User List (Vue with Server Data)</h3>
        
        <div class="data-source">
            <span class="badge" :class="dataSourceClass">
                Data: {{ dataSource }}
            </span>
            <button @click="refreshData" class="btn btn-sm" :disabled="loading">
                {{ loading ? 'Refreshing...' : 'Refresh from API' }}
            </button>
        </div>

        <div v-if="loading" class="loading">Loading...</div>
        
        <table class="table" v-else>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="user in users" :key="user.id">
                    <td>{{ user.id }}</td>
                    <td>{{ user.name }}</td>
                    <td>{{ user.email }}</td>
                    <td>
                        <span class="badge" :class="getRoleClass(user.role)">
                            {{ user.role }}
                        </span>
                    </td>
                    <td>
                        <button @click="editUser(user)" class="btn btn-sm btn-outline">Edit</button>
                        <button @click="deleteUser(user.id)" class="btn btn-sm btn-danger">Delete</button>
                    </td>
                </tr>
            </tbody>
        </table>

        <div v-if="users.length === 0" class="no-data">
            No users found
        </div>
    </div>
</template>

<script>
import { ref, onMounted, computed } from 'vue';

export default {
    name: 'UserList',
    setup(props, { attrs }) {
        const users = ref([]);
        const loading = ref(false);
        const dataSource = ref('server'); // 'server' or 'api'

        // Получаем initial данные из data-атрибутов
        const initialUsers = ref([]);
        
        onMounted(() => {
            // Способ 1: Из data-атрибутов
            const element = document.querySelector('[data-vue-app="UserList"]');
            if (element && element.dataset.initialUsers) {
                try {
                    initialUsers.value = JSON.parse(element.dataset.initialUsers);
                    users.value = initialUsers.value;
                    console.log('Loaded users from server data:', users.value);
                } catch (error) {
                    console.error('Error parsing initial users:', error);
                    users.value = [];
                }
            }
        });

        const refreshData = async () => {
            try {
                loading.value = true;
                dataSource.value = 'api';
                
                // Динамический импорт axios
                const axios = await import('axios');
                const response = await axios.default.get('/api/users');
                users.value = response.data;
            } catch (error) {
                console.error('Error fetching users from API:', error);
                // Возвращаемся к серверным данным при ошибке
                users.value = initialUsers.value;
                dataSource.value = 'server';
            } finally {
                loading.value = false;
            }
        };

        const editUser = (user) => {
            alert(`Editing user: ${user.name}\nEmail: ${user.email}`);
        };

        const deleteUser = (userId) => {
            if (confirm('Are you sure you want to delete this user?')) {
                users.value = users.value.filter(user => user.id !== userId);
            }
        };

        const getRoleClass = (role) => {
            const classes = {
                'Admin': 'badge-admin',
                'Moderator': 'badge-moderator',
                'User': 'badge-user'
            };
            return classes[role] || 'badge-secondary';
        };

        const dataSourceClass = computed(() => ({
            'badge-server': dataSource.value === 'server',
            'badge-api': dataSource.value === 'api'
        }));

        return {
            users,
            loading,
            dataSource,
            dataSourceClass,
            refreshData,
            editUser,
            deleteUser,
            getRoleClass
        };
    }
}
</script>

<style scoped>
.user-list {
    border: 2px solid #3498db;
    border-radius: 8px;
    padding: 20px;
    margin: 20px 0;
    background: #fff;
}

.data-source {
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    gap: 10px;
}

.table {
    width: 100%;
    border-collapse: collapse;
}

.table th,
.table td {
    padding: 8px 12px;
    border: 1px solid #ddd;
    text-align: left;
}

.table th {
    background: #f8f9fa;
    font-weight: bold;
}

.loading {
    text-align: center;
    padding: 20px;
    color: #666;
}

.no-data {
    text-align: center;
    padding: 20px;
    color: #999;
    font-style: italic;
}

.badge {
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 12px;
    font-weight: bold;
}

.badge-server {
    background: #27ae60;
    color: white;
}

.badge-api {
    background: #e67e22;
    color: white;
}

.badge-admin {
    background: #e74c3c;
    color: white;
}

.badge-moderator {
    background: #f39c12;
    color: white;
}

.badge-user {
    background: #3498db;
    color: white;
}

.badge-secondary {
    background: #95a5a6;
    color: white;
}

.btn {
    padding: 6px 12px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
}

.btn-sm {
    padding: 4px 8px;
    font-size: 11px;
}

.btn-outline {
    background: transparent;
    border: 1px solid #3498db;
    color: #3498db;
}

.btn-danger {
    background: #e74c3c;
    color: white;
}

.btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}
</style>
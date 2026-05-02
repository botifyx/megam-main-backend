require('dotenv').config();
const mysql = require('mysql2/promise');
const bcrypt = require('bcryptjs');

async function init() {
    try {
        const pool = mysql.createPool({
            host: process.env.DB_HOST || 'localhost',
            user: process.env.DB_USER || 'root',
            password: process.env.DB_PASS || '',
            database: process.env.DB_NAME || 'megam_live',
            port: process.env.DB_PORT || 3306,
        });

        console.log('Creating admin_users table if not exists...');
        await pool.query(`
            CREATE TABLE IF NOT EXISTS admin_users (
                id INT AUTO_INCREMENT PRIMARY KEY,
                username VARCHAR(100) UNIQUE NOT NULL,
                password_hash VARCHAR(255) NOT NULL
            )
        `);

        console.log('Checking for existing admin user...');
        const [rows] = await pool.query('SELECT * FROM admin_users WHERE username = ?', ['admin']);
        
        if (rows.length === 0) {
            console.log('Inserting default admin user...');
            const hash = await bcrypt.hash('MegamLive#1', 10);
            await pool.query('INSERT INTO admin_users (username, password_hash) VALUES (?, ?)', ['admin', hash]);
            console.log('Admin user initialized successfully with default password.');
        } else {
            console.log('Updating existing admin user password...');
            const hash = await bcrypt.hash('MegamLive#1', 10);
            await pool.query('UPDATE admin_users SET password_hash = ? WHERE username = ?', [hash, 'admin']);
            console.log('Admin user password updated successfully.');
        }

        process.exit(0);
    } catch (err) {
        console.error('Error initializing admin user:', err);
        process.exit(1);
    }
}

init();

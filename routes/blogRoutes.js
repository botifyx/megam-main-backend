const express = require('express');
const router = express.Router();
const db = require('../config/db');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const slugify = require('slugify');

// --- Multer Configuration ---
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        const uploadDir = 'uploads/blogs';
        if (!fs.existsSync(uploadDir)) {
            fs.mkdirSync(uploadDir, { recursive: true });
        }
        cb(null, uploadDir);
    },
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, uniqueSuffix + path.extname(file.originalname));
    }
});

const upload = multer({ 
    storage: storage,
    fileFilter: (req, file, cb) => {
        const filetypes = /jpeg|jpg|png|webp/;
        const mimetype = filetypes.test(file.mimetype);
        const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
        if (mimetype && extname) {
            return cb(null, true);
        }
        cb(new Error("Error: File upload only supports the following filetypes - " + filetypes));
    }
});

// --- GET All Blogs ---
router.get('/', async (req, res) => {
    try {
        const [blogs] = await db.query('SELECT * FROM blogs ORDER BY created_at DESC');
        res.json(blogs);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error fetching blogs' });
    }
});

// --- GET Single Blog by Slug ---
router.get('/:slug', async (req, res) => {
    try {
        const [blogs] = await db.query('SELECT * FROM blogs WHERE slug = ?', [req.params.slug]);
        if (blogs.length === 0) return res.status(404).json({ error: 'Blog not found' });
        res.json(blogs[0]);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error fetching blog' });
    }
});

// --- CREATE Blog ---
router.post('/', upload.single('image'), async (req, res) => {
    const { title, content, excerpt, author, category, image_url } = req.body;
    const imageUrl = req.file ? `/uploads/blogs/${req.file.filename}` : (image_url || null);
    const slug = slugify(title, { lower: true, strict: true }) + '-' + Date.now();

    try {
        const [result] = await db.query(
            'INSERT INTO blogs (title, slug, content, excerpt, author, image_url, category) VALUES (?, ?, ?, ?, ?, ?, ?)',
            [title, slug, content, excerpt, author, imageUrl, category]
        );
        res.status(201).json({ message: 'Blog created successfully', id: result.insertId });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error creating blog' });
    }
});

// --- UPDATE Blog ---
router.put('/:id', upload.single('image'), async (req, res) => {
    const { id } = req.params;
    const { title, content, excerpt, author, category } = req.body;
    let imageUrl = req.body.image_url; // Keep existing if no new file

    if (req.file) {
        imageUrl = `/uploads/blogs/${req.file.filename}`;
        // Optionally delete old image file here
    }

    const slug = slugify(title, { lower: true, strict: true });

    try {
        await db.query(
            'UPDATE blogs SET title=?, slug=?, content=?, excerpt=?, author=?, image_url=?, category=? WHERE id=?',
            [title, slug, content, excerpt, author, imageUrl, category, id]
        );
        res.json({ message: 'Blog updated successfully' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error updating blog' });
    }
});

// --- DELETE Blog ---
router.delete('/:id', async (req, res) => {
    try {
        // Get image URL to delete file
        const [blogs] = await db.query('SELECT image_url FROM blogs WHERE id = ?', [req.params.id]);
        if (blogs.length > 0 && blogs[0].image_url) {
            const filePath = path.join(__dirname, '..', blogs[0].image_url);
            if (fs.existsSync(filePath)) {
                fs.unlinkSync(filePath);
            }
        }

        await db.query('DELETE FROM blogs WHERE id = ?', [req.params.id]);
        res.json({ message: 'Blog deleted successfully' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error deleting blog' });
    }
});

module.exports = router;

const express = require('express');
const router = express.Router();
const db = require('../config/db');

// --- GET All Suites ---
router.get('/suites', async (req, res) => {
    try {
        const [suites] = await db.query('SELECT * FROM product_suites');
        
        // Fetch relations
        for (let suite of suites) {
            const [features] = await db.query('SELECT feature FROM suite_features WHERE suite_id = ?', [suite.id]);
            const [benefits] = await db.query('SELECT benefit FROM suite_benefits WHERE suite_id = ?', [suite.id]);
            const [badges] = await db.query('SELECT badge FROM suite_badges WHERE suite_id = ?', [suite.id]);
            
            suite.features = features.map(f => f.feature);
            suite.benefits = benefits.map(b => b.benefit);
            suite.badges = badges.map(b => b.badge);
        }
        
        res.json(suites);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error fetching suites' });
    }
});

// --- UPDATE Suite ---
router.put('/suites/:id', async (req, res) => {
    const { id } = req.params;
    const { title, productType, maturity, shortDescription, fullDescription, iconName, externalLink, features, benefits, badges } = req.body;
    
    try {
        await db.query(
            'UPDATE product_suites SET title=?, productType=?, maturity=?, shortDescription=?, fullDescription=?, iconName=?, externalLink=? WHERE id=?',
            [title, productType, maturity, shortDescription, fullDescription, iconName, externalLink, id]
        );
        
        // Handle features (replace all)
        if (features && Array.isArray(features)) {
            await db.query('DELETE FROM suite_features WHERE suite_id=?', [id]);
            for (let f of features) {
                await db.query('INSERT INTO suite_features (suite_id, feature) VALUES (?, ?)', [id, f]);
            }
        }
        
        // Handle benefits
        if (benefits && Array.isArray(benefits)) {
            await db.query('DELETE FROM suite_benefits WHERE suite_id=?', [id]);
            for (let b of benefits) {
                await db.query('INSERT INTO suite_benefits (suite_id, benefit) VALUES (?, ?)', [id, b]);
            }
        }
        
        // Handle badges
        if (badges && Array.isArray(badges)) {
            await db.query('DELETE FROM suite_badges WHERE suite_id=?', [id]);
            for (let b of badges) {
                await db.query('INSERT INTO suite_badges (suite_id, badge) VALUES (?, ?)', [id, b]);
            }
        }
        
        res.json({ message: 'Suite updated successfully' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error updating suite' });
    }
});

// --- GET All Case Studies ---
router.get('/case-studies', async (req, res) => {
    try {
        const [cases] = await db.query('SELECT * FROM case_studies');
        
        for (let c of cases) {
            const [metrics] = await db.query('SELECT label, value, suffix FROM case_study_metrics WHERE case_study_id = ?', [c.id]);
            c.metrics = metrics;
        }
        
        res.json(cases);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error fetching case studies' });
    }
});

// --- UPDATE Case Study ---
router.put('/case-studies/:id', async (req, res) => {
    const { id } = req.params;
    const { clientIndustry, title, outcome, metrics } = req.body;
    
    try {
        await db.query(
            'UPDATE case_studies SET clientIndustry=?, title=?, outcome=? WHERE id=?',
            [clientIndustry, title, outcome, id]
        );
        
        if (metrics && Array.isArray(metrics)) {
            await db.query('DELETE FROM case_study_metrics WHERE case_study_id=?', [id]);
            for (let m of metrics) {
                await db.query('INSERT INTO case_study_metrics (case_study_id, label, value, suffix) VALUES (?, ?, ?, ?)', [id, m.label, m.value, m.suffix]);
            }
        }
        
        res.json({ message: 'Case study updated successfully' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error updating case study' });
    }
});

// --- GET All Services ---
router.get('/services', async (req, res) => {
    try {
        const [services] = await db.query('SELECT * FROM services');
        res.json(services);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error fetching services' });
    }
});

// --- GENERAL CONTENT ---
router.get('/site-content', async (req, res) => {
    try {
        const [contents] = await db.query('SELECT * FROM site_content');
        const contentMap = {};
        for(let c of contents) {
            contentMap[c.key_name] = c.content_value;
        }
        res.json(contentMap);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error fetching site content' });
    }
});

router.put('/site-content/:key', async (req, res) => {
    const { key } = req.params;
    const { content_value } = req.body;
    try {
        // Upsert
        await db.query(
            'INSERT INTO site_content (key_name, content_value) VALUES (?, ?) ON DUPLICATE KEY UPDATE content_value = ?',
            [key, content_value, content_value]
        );
        res.json({ message: 'Content updated successfully' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error updating site content' });
    }
});

// --- RELEASE EVENTS ---
router.get('/release-events', async (req, res) => {
    try {
        const [events] = await db.query('SELECT * FROM release_events');
        res.json(events);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error fetching release events' });
    }
});

router.put('/release-events', async (req, res) => {
    // Expects an array of events
    const events = req.body;
    if (!Array.isArray(events)) {
        return res.status(400).json({ error: 'Expected an array of release events' });
    }
    
    try {
        // Simple replace all for admin sync
        await db.query('TRUNCATE TABLE release_events');
        
        for (let ev of events) {
            await db.query(
                'INSERT INTO release_events (monthYear, product, feature, status, source) VALUES (?, ?, ?, ?, ?)',
                [ev.monthYear, ev.product, ev.feature, ev.status, ev.source]
            );
        }
        res.json({ message: 'Release events updated successfully' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error updating release events' });
    }
});

module.exports = router;

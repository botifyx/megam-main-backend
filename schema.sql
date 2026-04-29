CREATE DATABASE IF NOT EXISTS `megam_live`;
USE `megam_live`;

CREATE TABLE IF NOT EXISTS `product_suites` (
  `id` VARCHAR(50) PRIMARY KEY,
  `title` VARCHAR(255) NOT NULL,
  `productType` VARCHAR(100),
  `maturity` VARCHAR(50),
  `shortDescription` TEXT,
  `fullDescription` TEXT,
  `iconName` VARCHAR(50),
  `externalLink` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `suite_features` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `suite_id` VARCHAR(50),
  `feature` TEXT,
  FOREIGN KEY (`suite_id`) REFERENCES `product_suites`(`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `suite_benefits` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `suite_id` VARCHAR(50),
  `benefit` TEXT,
  FOREIGN KEY (`suite_id`) REFERENCES `product_suites`(`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `suite_badges` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `suite_id` VARCHAR(50),
  `badge` VARCHAR(100),
  FOREIGN KEY (`suite_id`) REFERENCES `product_suites`(`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `services` (
  `id` VARCHAR(50) PRIMARY KEY,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT,
  `iconName` VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS `case_studies` (
  `id` VARCHAR(50) PRIMARY KEY,
  `clientIndustry` VARCHAR(100),
  `title` VARCHAR(255) NOT NULL,
  `outcome` TEXT
);

CREATE TABLE IF NOT EXISTS `case_study_metrics` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `case_study_id` VARCHAR(50),
  `label` VARCHAR(100),
  `value` VARCHAR(50),
  `suffix` VARCHAR(50),
  FOREIGN KEY (`case_study_id`) REFERENCES `case_studies`(`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `site_content` (
  `key_name` VARCHAR(100) PRIMARY KEY,
  `content_value` TEXT
);

CREATE TABLE IF NOT EXISTS `release_events` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `monthYear` VARCHAR(50),
  `product` VARCHAR(100),
  `feature` TEXT,
  `status` VARCHAR(50),
  `source` VARCHAR(100)
);

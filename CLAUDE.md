# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Salesforce DX project named "AgentforceVibes" using API version 66.0. The project follows the standard Salesforce DX structure with source code organized under `force-app/main/default/`.

## Development Commands

### Build and Test
- `npm run lint` - Lint all Aura and LWC JavaScript files
- `npm test` or `npm run test:unit` - Run all LWC Jest unit tests
- `npm run test:unit:watch` - Run tests in watch mode
- `npm run test:unit:debug` - Run tests in debug mode
- `npm run test:unit:coverage` - Run tests with coverage report

### Code Formatting
- `npm run prettier` - Auto-format all code files (Apex, Aura, LWC, config files)
- `npm run prettier:verify` - Check formatting without making changes

### Pre-commit Hooks
The project uses Husky and lint-staged to automatically:
- Format code with Prettier
- Lint JavaScript files
- Run related LWC Jest tests

## Project Structure

### Source Code (`force-app/main/default/`)
- `classes/` - Apex classes
- `triggers/` - Apex triggers
- `lwc/` - Lightning Web Components
- `aura/` - Aura components
- `objects/` - Custom object definitions
- `permissionsets/` - Permission sets
- `flexipages/` - Lightning page layouts
- `applications/` - App definitions
- `tabs/` - Custom tabs
- `layouts/` - Page layouts
- `staticresources/` - Static resources
- `contentassets/` - Content assets

### Configuration
- `sfdx-project.json` - Salesforce DX project configuration
- `config/project-scratch-def.json` - Scratch org definition
- `eslint.config.js` - ESLint configuration for Aura and LWC components
- `jest.config.js` - Jest test configuration for LWC

### Scripts
- `scripts/apex/` - Apex scripts for execution
- `scripts/soql/` - SOQL queries for testing

## Code Organization

### Lightning Web Components
- Located in `force-app/main/default/lwc/`
- Each component has its own directory with `.js`, `.html`, `.js-meta.xml`, and optionally `.css` files
- Test files use `.test.js` suffix and run with `@salesforce/sfdx-lwc-jest`
- ESLint rules from `@salesforce/eslint-config-lwc` apply
- Test files have relaxed wire adapter rules for mocking

### Aura Components
- Located in `force-app/main/default/aura/`
- ESLint uses `@salesforce/eslint-plugin-aura` with recommended and locker service rules

### Apex
- Classes in `force-app/main/default/classes/`
- Triggers in `force-app/main/default/triggers/`
- Formatted with Prettier using `prettier-plugin-apex`

## Salesforce CLI

This project uses Salesforce CLI (sf/sfdx commands) for:
- Deploying to orgs: `sf project deploy start`
- Retrieving metadata: `sf project retrieve start`
- Running Apex tests: `sf apex run test`
- Creating scratch orgs: `sf org create scratch`

The default login URL is `https://login.salesforce.com` (production/developer orgs).

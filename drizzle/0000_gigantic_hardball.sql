CREATE TABLE `automations` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`trigger` text NOT NULL,
	`action` text NOT NULL,
	`enabled` integer DEFAULT true NOT NULL,
	`runs` integer DEFAULT 0 NOT NULL,
	`created_at` text DEFAULT CURRENT_TIMESTAMP NOT NULL
);
--> statement-breakpoint
CREATE TABLE `customers` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`phone` text NOT NULL,
	`email` text,
	`total_spent` real DEFAULT 0 NOT NULL,
	`purchases` integer DEFAULT 0 NOT NULL,
	`warranty_items` integer DEFAULT 0 NOT NULL,
	`created_at` text DEFAULT CURRENT_TIMESTAMP NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `customers_phone_unique` ON `customers` (`phone`);--> statement-breakpoint
CREATE TABLE `expenses` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`title` text NOT NULL,
	`category` text NOT NULL,
	`amount` real NOT NULL,
	`branch` text NOT NULL,
	`approved_by` text NOT NULL,
	`created_at` text DEFAULT CURRENT_TIMESTAMP NOT NULL
);
--> statement-breakpoint
CREATE TABLE `products` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`sku` text NOT NULL,
	`category` text NOT NULL,
	`serial_number` text,
	`cost` real NOT NULL,
	`price` real NOT NULL,
	`stock` integer DEFAULT 0 NOT NULL,
	`reorder_level` integer DEFAULT 5 NOT NULL,
	`branch` text DEFAULT 'Main Branch' NOT NULL,
	`created_at` text DEFAULT CURRENT_TIMESTAMP NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `products_sku_unique` ON `products` (`sku`);--> statement-breakpoint
CREATE TABLE `sales` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`order_number` text NOT NULL,
	`product_name` text NOT NULL,
	`customer_name` text NOT NULL,
	`quantity` integer DEFAULT 1 NOT NULL,
	`amount` real NOT NULL,
	`cost` real NOT NULL,
	`channel` text NOT NULL,
	`branch` text NOT NULL,
	`salesperson` text NOT NULL,
	`status` text DEFAULT 'paid' NOT NULL,
	`created_at` text DEFAULT CURRENT_TIMESTAMP NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `sales_order_number_unique` ON `sales` (`order_number`);--> statement-breakpoint
CREATE TABLE `suppliers` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`contact` text NOT NULL,
	`category` text NOT NULL,
	`balance` real DEFAULT 0 NOT NULL,
	`lead_days` integer DEFAULT 7 NOT NULL,
	`status` text DEFAULT 'active' NOT NULL,
	`created_at` text DEFAULT CURRENT_TIMESTAMP NOT NULL
);
--> statement-breakpoint
CREATE TABLE `warranties` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`serial_number` text NOT NULL,
	`customer_name` text NOT NULL,
	`product_name` text NOT NULL,
	`expires_at` text NOT NULL,
	`status` text DEFAULT 'active' NOT NULL,
	`created_at` text DEFAULT CURRENT_TIMESTAMP NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `warranties_serial_number_unique` ON `warranties` (`serial_number`);
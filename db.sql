CREATE
	TABLE
		"pos_base"(
			"id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
			"updated" datetime NOT NULL,
			"uploaded" datetime NOT NULL,
			"note" text NULL,
			"active" bool NOT NULL
		);

CREATE
	TABLE
		"pos_config"(
			"pos_base_ptr_id" integer NOT NULL PRIMARY KEY REFERENCES "pos_base"("id"),
			"value" varchar(40) NOT NULL
		);

CREATE
	TABLE
		"pos_msg"(
			"pos_base_ptr_id" integer NOT NULL PRIMARY KEY REFERENCES "pos_base"("id"),
			"state" varchar(1) NULL,
			"msg_from" varchar(40) NOT NULL,
			"msg_to" varchar(40) NOT NULL
		);

CREATE
	TABLE
		"pos_order"(
			"pos_base_ptr_id" integer NOT NULL PRIMARY KEY REFERENCES "pos_base"("id"),
			"ordered" datetime NOT NULL,
			"price" real NOT NULL,
			"paid" real NOT NULL,
			"change" real NOT NULL,
			"state" varchar(3) NOT NULL
		);

CREATE
	TABLE
		"pos_orderline"(
			"pos_base_ptr_id" integer NOT NULL PRIMARY KEY REFERENCES "pos_base"("id"),
			"name" varchar(40) NOT NULL,
			"qty" real NOT NULL,
			"price_unit" real NOT NULL,
			"discount" real NOT NULL,
			"price" real NOT NULL,
			"pos_order_id" integer NOT NULL REFERENCES "pos_order"("pos_base_ptr_id"),
			"pos_product_id" integer NOT NULL REFERENCES "pos_product"("pos_base_ptr_id"),
			"pos_unit_id" integer NOT NULL REFERENCES "pos_unit"("pos_base_ptr_id")
		);

CREATE
	TABLE
		"pos_product"(
			"pos_base_ptr_id" integer NOT NULL PRIMARY KEY REFERENCES "pos_base"("id"),
			"name" varchar(40) NOT NULL UNIQUE,
			"price" real NOT NULL,
			"code" varchar(40) NULL UNIQUE,
			"unit" varchar(10) NULL
		);

CREATE
	TABLE
		"pos_product_pos_tag"(
			"id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
			"pos_product_id" integer NOT NULL REFERENCES "pos_product"("pos_base_ptr_id"),
			"pos_tag_id" integer NOT NULL REFERENCES "pos_tag"("pos_base_ptr_id")
		);

CREATE
	TABLE
		"pos_stock"(
			"pos_base_ptr_id" integer NOT NULL PRIMARY KEY REFERENCES "pos_base"("id"),
			"ordered" datetime NOT NULL,
			"state" varchar(3) NOT NULL,
			"pos_order_id" integer NULL REFERENCES "pos_order"("pos_base_ptr_id"),
			"pos_stock_id" integer NULL REFERENCES "pos_stock"("pos_base_ptr_id")
		);

CREATE
	TABLE
		"pos_stockline"(
			"pos_base_ptr_id" integer NOT NULL PRIMARY KEY REFERENCES "pos_base"("id"),
			"qty" real NOT NULL,
			"pos_order_line_id" integer NULL REFERENCES "pos_orderline"("pos_base_ptr_id"),
			"pos_product_id" integer NOT NULL REFERENCES "pos_product"("pos_base_ptr_id")
		);

CREATE
	TABLE
		"pos_tag"(
			"pos_base_ptr_id" integer NOT NULL PRIMARY KEY REFERENCES "pos_base"("id"),
			"name" varchar(40) NOT NULL UNIQUE
		);

CREATE
	TABLE
		"pos_unit"(
			"pos_base_ptr_id" integer NOT NULL PRIMARY KEY REFERENCES "pos_base"("id"),
			"name" varchar(40) NOT NULL,
			"factor" real NOT NULL,
			"pos_product_id" integer NOT NULL REFERENCES "pos_product"("pos_base_ptr_id")
		);

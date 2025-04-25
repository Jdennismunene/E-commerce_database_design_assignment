create database Ecommerce;
use Ecommerce;

create table product_image(
 Id int primary key,
 product_id int not null,
 image_url varchar(255) not null,
 image_name varchar(40),
 image_position int default 0
);

create table color(
  color_id int primary key,
  product_id int not null,
  color_name varchar(40),
  color_code varchar(10)
);

create table product_category(
  category_id int primary key,
  category_name varchar(40),
  category_image varchar(255),
  category_description varchar(255)
);
create table product(
  product_id int primary key,
  Id int not null,
  product_name varchar(40),
  product_description varchar(255),
  product_price decimal(10, 2) not null,
  brand_id int,
  category_id int,
  product_sku varchar(40),
  product_status enum('active', 'inactive') default 'active',
  foreign key (category_id) references product_category(category_id) on delete set null
);

alter table product_image
add foreign key (product_id)
references product (product_id);

alter table color
add foreign key (product_id)
references product (product_id);

create table product_item(
  item_id int primary key,
  product_id int,
  item_name varchar(40),
  variant_id int,
  item_status enum('in_stock', 'sold', 'returned') default 'in_stock',
  foreign key (product_id) references product (product_id) on delete set null
);

create table brand(
  brand_id int primary key,
  brand_name varchar(40),
  brand_description varchar(255),
  brand_logo varchar(255)
);

alter table product
add foreign key (brand_id)
references brand (brand_id) 
on delete set null;

create table product_variation(
  variation_id int primary key,
  product_id int,
  color_id int,
  size_id int,
  attribute_id int,
  foreign key (product_id) references product (product_id) on delete set null,
  foreign key (color_id) references color (color_id) on delete set null
);

create table size_category(
  size_category_id int primary key,
  category_id int,
  size_category_name varchar(40),
  size_category_description varchar(255),
  foreign key (category_id) references product_category (category_id) on delete set null
);

create table size_option(
  size_id int primary key,
  size_label varchar(40),
  variation_id int,
  size_category_id int,
  foreign key (size_category_id) references size_category(size_category_id) on delete set null,
  foreign key (variation_id) references product_variation(variation_id) on delete set null
);

alter table product_variation 
add foreign key (size_id)
references size_option(size_id)
on delete set null;

create table product_attribute(
  attribute_id int primary key,
  attribute_name varchar(40),
  attribute_value varchar(40),
  product_id int,
  foreign key (product_id) references product (product_id) on delete set null
);

alter table product_variation
add foreign key (attribute_id)
references product_attribute (attribute_id)
on delete set null;

create table attribute_category(
  attribute_category_id int primary key,
  attribute_category_name varchar(40),
  attribute_category_desc varchar(255)
);

alter table product_attribute
add attribute_category_id int,
add foreign key (attribute_category_id) 
references attribute_category (attribute_category_id) 
on delete set null;

create table attribute_type(
  attribute_type_id int primary key,
  attribute_type_name varchar(40),
  attribute_type_description varchar(255)
);

alter table product_attribute
add attribute_type_id int,
add foreign key (attribute_type_id)
references attribute_type(attribute_type_id)
on delete set null;

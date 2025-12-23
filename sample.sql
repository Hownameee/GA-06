-- 1. CLEAN UP (Xóa bảng cũ theo thứ tự ràng buộc)
DROP TABLE IF EXISTS "orders";
DROP TABLE IF EXISTS "users";
DROP TABLE IF EXISTS "wards";
DROP TABLE IF EXISTS "provinces";

-- 2. TẠO BẢNG
CREATE TABLE "provinces" (
  "id" integer PRIMARY KEY, -- ID giữ nguyên theo file json để map dữ liệu
  "name" varchar(256) NOT NULL,
  "name_with_type" varchar(256) NOT NULL
);

CREATE TABLE "wards" (
  "id" integer PRIMARY KEY, -- ID giữ nguyên theo file json
  "name" varchar(256) NOT NULL,
  "name_with_type" varchar(256) NOT NULL,
  "province_id" integer NOT NULL
);

CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY, -- TỰ ĐỘNG TĂNG (Auto-increment)
  "email" varchar(256) NOT NULL UNIQUE,
  "encrypted_password" varchar(256) NOT NULL,
  "is_admin" boolean NOT NULL DEFAULT FALSE,
  "is_active" boolean NOT NULL DEFAULT FALSE,
  "otp" varchar(256)
);

CREATE TABLE "orders" (
  "id" integer PRIMARY KEY, -- Giữ ID cụ thể nếu cần quản lý đơn hàng theo mã định danh ngoài
  "recipient" varchar(256) NOT NULL,
  "house_number" varchar(256) NOT NULL,
  "street" varchar(256) NOT NULL,
  "province_id" integer NOT NULL,
  "ward_id" integer NOT NULL
);

-- 3. IMPORT DATA

-- Users: Không cần điền ID, hệ thống sẽ tự sinh (1, 2, ...)
INSERT INTO "users" ("email", "encrypted_password", "is_admin", "is_active", "otp") VALUES
('admin@example.com', '$2b$10$EpIqEpIqEpIqEpIqEpIqEu', true, true, NULL),

-- Provinces: Dữ liệu từ file province.json
INSERT INTO "provinces" ("id", "name", "name_with_type") VALUES
(11, 'Hà Nội', 'Thành phố Hà Nội'),
(12, 'Hồ Chí Minh', 'Thành phố Hồ Chí Minh'),
(13, 'Đà Nẵng', 'Thành phố Đà Nẵng'),
(14, 'Hải Phòng', 'Thành phố Hải Phòng'),
(15, 'Cần Thơ', 'Thành phố Cần Thơ'),
(16, 'Huế', 'Thành phố Huế'),
(17, 'An Giang', 'Tỉnh An Giang'),
(18, 'Bắc Ninh', 'Tỉnh Bắc Ninh'),
(19, 'Cà Mau', 'Tỉnh Cà Mau'),
(20, 'Cao Bằng', 'Tỉnh Cao Bằng'),
(21, 'Đắk Lắk', 'Tỉnh Đắk Lắk'),
(22, 'Điện Biên', 'Tỉnh Điện Biên'),
(23, 'Đồng Nai', 'Tỉnh Đồng Nai'),
(24, 'Đồng Tháp', 'Tỉnh Đồng Tháp'),
(25, 'Gia Lai', 'Tỉnh Gia Lai'),
(26, 'Hà Tĩnh', 'Tỉnh Hà Tĩnh'),
(27, 'Hưng Yên', 'Tỉnh Hưng Yên'),
(28, 'Khánh Hòa', 'Tỉnh Khánh Hòa'),
(29, 'Lai Châu', 'Tỉnh Lai Châu'),
(30, 'Lâm Đồng', 'Tỉnh Lâm Đồng'),
(31, 'Lạng Sơn', 'Tỉnh Lạng Sơn'),
(32, 'Lào Cai', 'Tỉnh Lào Cai'),
(33, 'Nghệ An', 'Tỉnh Nghệ An'),
(34, 'Ninh Bình', 'Tỉnh Ninh Bình'),
(35, 'Phú Thọ', 'Tỉnh Phú Thọ'),
(36, 'Quảng Ngãi', 'Tỉnh Quảng Ngãi'),
(37, 'Quảng Ninh', 'Tỉnh Quảng Ninh'),
(38, 'Quảng Trị', 'Tỉnh Quảng Trị'),
(39, 'Sơn La', 'Tỉnh Sơn La'),
(40, 'Tây Ninh', 'Tỉnh Tây Ninh'),
(41, 'Thái Nguyên', 'Tỉnh Thái Nguyên'),
(42, 'Thanh Hóa', 'Tỉnh Thanh Hóa'),
(43, 'Tuyên Quang', 'Tỉnh Tuyên Quang'),
(44, 'Vĩnh Long', 'Tỉnh Vĩnh Long');

-- Wards: Import mẫu các Phường/Xã cần thiết (vì danh sách full >3000 dòng)
INSERT INTO "wards" ("id", "name", "name_with_type", "province_id") VALUES
(4108, 'Chánh Hưng', 'Phường Chánh Hưng', 12), -- Phường dùng trong Order
(267, 'Minh Châu', 'Xã Minh Châu', 11),
(268, 'Thạnh An', 'Xã Thạnh An', 12),
(269, 'Tam Hải', 'Xã Tam Hải', 13),
(270, 'Mao Điền', 'Xã Mao Điền', 14);

-- Orders: Dữ liệu mẫu
INSERT INTO "orders" ("id", "recipient", "house_number", "street", "province_id", "ward_id") VALUES
(1, 'Kha Do', '123', 'Nguyễn Trãi', 12, 4108),
(2, 'Trần Thị B', '123', 'Lê Duẩn', 12, 4108);
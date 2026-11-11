CREATE DATABASE HRMDB;
GO
USE HRMDB;
GO

-- 1. Bảng Phòng ban
CREATE TABLE PhongBan (
    MaPB INT IDENTITY(1,1) PRIMARY KEY,
    TenPB NVARCHAR(100) NOT NULL,
    Mota NVARCHAR(255)
);

-- 2. Bảng Hồ sơ nhân viên
CREATE TABLE NhanVien (
    MaNV INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATETIME,
    CCCD VARCHAR(20) UNIQUE,
    MaPB INT FOREIGN KEY REFERENCES PhongBan(MaPB),
    LuongCoBan DECIMAL(18,2) CHECK (LuongCoBan > 0),
    HeSoLuong FLOAT DEFAULT 1.0
);

-- 3. Bảng Chấm công tháng
CREATE TABLE BangChamCong (
    MaCong INT IDENTITY(1,1) PRIMARY KEY,
    MaNV INT FOREIGN KEY REFERENCES NhanVien(MaNV),
    ThangNam VARCHAR(7) NOT NULL,
    SoNgayCong FLOAT DEFAULT 0 CHECK (SoNgayCong >= 0 AND SoNgayCong <= 31),
    SoGioOT FLOAT DEFAULT 0 CHECK (SoGioOT >= 0),
    DaChot BIT DEFAULT 0,
    CONSTRAINT UQ_NhanVien_Thang UNIQUE (MaNV, ThangNam)
);

-- 4. Bảng Lương chi tiết
CREATE TABLE BangLuong (
    MaLuong INT IDENTITY(1,1),
    MaNV INT FOREIGN KEY REFERENCES NhanVien(MaNV),
    ThangNam VARCHAR(7),
    ThucLinh DECIMAL(18,2),
    PRIMARY KEY (MaNV, ThangNam)
);

-- Thêm dữ liệu mẫu để test ngay
INSERT INTO PhongBan (TenPB, Mota) VALUES 
(N'Phòng Kỹ Thuật', N'Phát triển phần mềm'),
(N'Phòng Kế Toán', N'Quản lý tài chính'),
(N'Phòng Nhân Sự', N'Tuyển dụng và đào tạo');

INSERT INTO NhanVien (HoTen, NgaySinh, CCCD, MaPB, LuongCoBan, HeSoLuong) VALUES 
(N'Lê Văn Cường', '1998-05-15', '001098001122', 1, 10000000, 1.5),
(N'Phạm Thị Dung', '2000-10-20', '001200003344', 2, 8000000, 1.2),
(N'Hoàng Minh Tuấn', '1995-03-08', '001095005566', 1, 12000000, 1.8);

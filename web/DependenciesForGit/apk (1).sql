-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-11-2024 a las 17:03:31
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `apk`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `category`
--

CREATE TABLE `category` (
  `idCategory` int(11) NOT NULL,
  `nameCategory` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `category`
--

INSERT INTO `category` (`idCategory`, `nameCategory`) VALUES
(1, 'Bebidas'),
(2, 'Chocolates'),
(5, 'Abarrotes'),
(6, 'Cereales'),
(7, 'Galletas'),
(8, 'Caramelos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idClient` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idClient`, `name`, `lastname`, `email`, `phone`, `address`, `password`) VALUES
(1, 'Carlos', 'Quispe', 'carquis@gmail.com', '987654321', 'Villa San Juan', ''),
(2, 'DiegoCliente', 'Soncco', 'diego@123.com', '214365879', 'PorAhi', '321');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employee`
--

CREATE TABLE `employee` (
  `idEmployee` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `employee`
--

INSERT INTO `employee` (`idEmployee`, `name`, `username`, `password`) VALUES
(1, 'Diego Soncco', 'diegogo', '123'),
(2, 'Javier asd', 'jav', '321');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product`
--

CREATE TABLE `product` (
  `idProduct` int(11) NOT NULL,
  `nameProduct` varchar(100) NOT NULL,
  `description` varchar(150) NOT NULL,
  `price` double NOT NULL,
  `idCategory` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `img` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `product`
--

INSERT INTO `product` (`idProduct`, `nameProduct`, `description`, `price`, `idCategory`, `stock`, `img`) VALUES
(1, 'CocaCola', 'CocoCola de 3L no retornable', 11, 1, 6, 'https://metroio.vtexassets.com/arquivos/ids/517838-1200-auto?v=638469960103600000&width=1200&height=auto&aspect=true'),
(4, 'Pepsi', 'Pepsi 3L', 8, 1, 19, 'https://metroio.vtexassets.com/arquivos/ids/237424-1200-auto?v=638173434828430000&width=1200&height=auto&aspect=true'),
(5, 'Chomp', 'Paquete: Galleta chomp sabor chocolate 6un', 5.2, 7, 15, 'https://metroio.vtexassets.com/arquivos/ids/240706-1200-auto?v=638173829442300000&width=1200&height=auto&aspect=true'),
(6, 'Picaras', 'Galletas PICARAS Clasicas Paquete 6un', 5.3, 7, 10, 'https://plazavea.vteximg.com.br/arquivos/ids/29179436-1000-1000/1057455002.jpg'),
(7, 'FIELD', 'Galletas FIELD Vainilla Paquete 6un', 5, 7, 30, 'https://plazavea.vteximg.com.br/arquivos/ids/29033244-1000-1000/243940.jpg'),
(8, 'Chokosoda', 'Galletas FIELD ChokoSoda Paquete 6un', 6.2, 7, 20, 'https://plazavea.vteximg.com.br/arquivos/ids/29033248-184-184/358248.jpg?v=638501473601100000'),
(9, 'Galleta Animalitos', 'Galletas Animalitos SAN JORGE Bolsa 500g', 5, 7, 30, 'https://plazavea.vteximg.com.br/arquivos/ids/553941-184-184/374262.jpg?v=637426569771770000'),
(10, 'Dona Pepa', 'Galleta Dona Pepa FIELD Paquete 6un', 4.7, 7, 10, 'https://plazavea.vteximg.com.br/arquivos/ids/29033207-1000-1000/20000443.jpg'),
(11, 'Fanta Naranja', 'Gaseosa FANTA Naranja Botella 3L', 6.9, 1, 15, 'https://plazavea.vteximg.com.br/arquivos/ids/29684621-1000-1000/29856.jpg'),
(12, 'Gasesosas Multisabor', 'Gaseosas MULTISABOR Botella 300ml Paquete 12un', 19.5, 1, 19, 'https://plazavea.vteximg.com.br/arquivos/ids/29454430-1000-1000/20427556.jpg'),
(13, 'BigCola', 'Gaseosa BIG COLA Botella 3.03L', 6.5, 1, 13, 'https://plazavea.vteximg.com.br/arquivos/ids/29322650-1000-1000/20238217.jpg'),
(14, 'Paquete Cocacola 300ml', 'Gaseosa COCA COLA Sin Azucar Botella 300ml Paquete 6un', 10, 1, 10, 'https://plazavea.vteximg.com.br/arquivos/ids/29684622-1000-1000/20136607.jpg'),
(15, 'Gloria Maracuya', 'Bebida GLORIA Maracuya Caja 1L', 3.9, 1, 10, 'https://plazavea.vteximg.com.br/arquivos/ids/2248142-1000-1000/20065707.jpg'),
(16, 'Chocolate Milky', 'Barra milky la Iberica x 50 g x 10Un', 38, 2, 10, 'https://www.laiberica.com.pe/files/productos/presentaciones/20230920154359.png'),
(17, 'Chocolate Hershey\'s', 'Chocolate HERSHEY\'S 40% Cacao Tableta 82g', 9.5, 2, 15, 'https://plazavea.vteximg.com.br/arquivos/ids/28527184-1000-1000/20393397.jpg'),
(18, 'Chocolate Triangulo', 'Chocolate TRIANGULO Clasico Caja 10un NESTLE', 14.2, 2, 15, 'https://plazavea.vteximg.com.br/arquivos/ids/2240226-1000-1000/20236559.jpg'),
(19, 'Bombones Sublime', 'Chocolate NESTLE Sublime Bombones Especial Caja 16un', 11.8, 2, 17, 'https://plazavea.vteximg.com.br/arquivos/ids/28885741-1000-1000/20281981.jpg'),
(20, 'Beso de Moza', 'Chocolate BESOS DE MOZA Clasico Caja 9un x 24g', 10, 2, 10, 'https://plazavea.vteximg.com.br/arquivos/ids/28885609-1000-1000/130745.jpg'),
(21, 'Barra de cereal chips', 'Cereal Bar COSTA Chips Caja 12un', 5.8, 6, 15, 'https://plazavea.vteximg.com.br/arquivos/ids/28893082-1000-1000/20214623.jpg'),
(22, 'Corn Flakes no Gluten', 'Cereal NESTLE Corn Flakes sin Gluten Bolsa 740g', 20.5, 6, 20, 'https://plazavea.vteximg.com.br/arquivos/ids/28884629-1000-1000/20392944.jpg'),
(23, 'Cereal trigo con chocolate', 'Cereal ANGEL Capas de trigo con chocolate Bolsa 380Gr', 11.5, 6, 20, 'https://plazavea.vteximg.com.br/arquivos/ids/17039526-1000-1000/20058032.jpg'),
(24, 'Cereal Flakes', 'Cereal ANGEL Flakes Bolsa 1Kg', 15.2, 6, 13, 'https://plazavea.vteximg.com.br/arquivos/ids/554226-1000-1000/969599.jpg'),
(25, 'Cereal chocapic', 'Cereal CHOCAPIC Caja 540g', 20.5, 6, 16, 'https://plazavea.vteximg.com.br/arquivos/ids/27427569-1000-1000/20257644.jpg'),
(26, 'Cereal Zuck', 'Cereal ANGEL Zuck Bolsa 130g', 3, 6, 12, 'https://plazavea.vteximg.com.br/arquivos/ids/25713692-1000-1000/20329006.jpg'),
(27, 'Chupetines Shake', 'Chupetines GLOBO POP Shake Bolsa 432g', 7.5, 8, 20, 'https://plazavea.vteximg.com.br/arquivos/ids/18082666-1000-1000/20283852.jpg'),
(28, 'Caramelos duros sabor Mentol', 'Caramelos Duro De Gingseng Sabor Mentol 380gr Ren Shen Tang', 16, 8, 9, 'https://plazavea.vteximg.com.br/arquivos/ids/30001845-1000-1000/imageUrl_1.jpg'),
(29, 'Caramelo perita', 'Caramelos Sayon Perita 380g', 5.9, 8, 20, 'https://metroio.vtexassets.com/arquivos/ids/246480-1200-auto?v=638173942711870000&width=1200&height=auto&aspect=true'),
(30, 'Caramelos de Limon', 'Caramelos Arcor Limon Bolsa 390 g', 10, 8, 25, 'https://metroio.vtexassets.com/arquivos/ids/240352-1200-auto?v=638173827666200000&width=1200&height=auto&aspect=true'),
(31, 'Caramelos Mogul', 'Caramelos Masticables Mogul SÃºper Blando 100un', 12.8, 8, 12, 'https://metroio.vtexassets.com/arquivos/ids/512812-1200-auto?v=638433669911970000&width=1200&height=auto&aspect=true'),
(32, 'Caramelos Mentos', 'Caramelos Masticables Menta Air Action Mentos Barra 29.7 g', 2, 8, 20, 'https://metroio.vtexassets.com/arquivos/ids/335225-1200-auto?v=638180572918730000&width=1200&height=auto&aspect=true');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sale`
--

CREATE TABLE `sale` (
  `idSale` int(11) NOT NULL,
  `idClient` int(11) NOT NULL,
  `totalPrice` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sale`
--

INSERT INTO `sale` (`idSale`, `idClient`, `totalPrice`, `date`) VALUES
(1, -1, 11, '2024-11-18'),
(2, -1, 11, '2024-11-18'),
(3, -1, 19, '2024-11-18'),
(4, -1, 19, '2024-11-18'),
(5, -1, 11, '2024-11-18'),
(6, 2, 8, '2024-11-19'),
(7, 2, 11, '2024-11-19'),
(8, 2, 8, '2024-11-19'),
(9, 2, 11, '2024-11-19'),
(10, 2, 11, '2024-11-19'),
(11, 2, 1, '2024-11-19'),
(12, 2, 11, '2024-11-19'),
(13, 2, 11, '2024-11-19'),
(14, 2, 11, '2024-11-19'),
(15, 2, 20, '2024-11-19'),
(16, 2, 8, '2024-11-19'),
(17, 2, 15, '2024-11-19'),
(18, 2, 15, '2024-11-19'),
(19, 2, 11, '2024-11-19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `saledetail`
--

CREATE TABLE `saledetail` (
  `idSaleDetail` int(11) NOT NULL,
  `idSale` int(11) NOT NULL,
  `idProduct` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `price` double NOT NULL,
  `discount` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `saledetail`
--

INSERT INTO `saledetail` (`idSaleDetail`, `idSale`, `idProduct`, `amount`, `price`, `discount`) VALUES
(1, 1, 1, 5, 55, 0),
(2, 2, 1, 2, 22, 0),
(3, 3, 1, 2, 22, 0),
(4, 3, 4, 3, 24, 0),
(5, 4, 1, 2, 22, 0),
(6, 4, 4, 3, 24, 0),
(7, 5, 1, 1, 11, 0),
(8, 6, 4, 2, 16, 0),
(9, 7, 1, 3, 33, 0),
(10, 8, 4, 3, 24, 0),
(11, 9, 1, 2, 22, 0),
(12, 10, 1, 2, 22, 0),
(13, 11, 5, 2, 2, 0),
(14, 12, 1, 2, 22, 0),
(15, 13, 1, 2, 22, 0),
(16, 14, 1, 2, 22, 0),
(17, 15, 12, 1, 19.5, 0),
(18, 16, 4, 1, 8, 0),
(19, 17, 13, 2, 13, 0),
(20, 17, 4, 2, 16, 0),
(21, 18, 13, 2, 13, 0),
(22, 18, 4, 2, 16, 0),
(23, 19, 1, 1, 11, 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`idCategory`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idClient`);

--
-- Indices de la tabla `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`idEmployee`);

--
-- Indices de la tabla `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`idProduct`),
  ADD KEY `fk_products_category` (`idCategory`);

--
-- Indices de la tabla `sale`
--
ALTER TABLE `sale`
  ADD PRIMARY KEY (`idSale`);

--
-- Indices de la tabla `saledetail`
--
ALTER TABLE `saledetail`
  ADD PRIMARY KEY (`idSaleDetail`),
  ADD KEY `fk_saledetail_sale` (`idSale`),
  ADD KEY `fk_saledetail_products` (`idProduct`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `category`
--
ALTER TABLE `category`
  MODIFY `idCategory` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idClient` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `employee`
--
ALTER TABLE `employee`
  MODIFY `idEmployee` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `product`
--
ALTER TABLE `product`
  MODIFY `idProduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `sale`
--
ALTER TABLE `sale`
  MODIFY `idSale` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `saledetail`
--
ALTER TABLE `saledetail`
  MODIFY `idSaleDetail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`idCategory`) REFERENCES `category` (`idCategory`);

--
-- Filtros para la tabla `saledetail`
--
ALTER TABLE `saledetail`
  ADD CONSTRAINT `fk_saledetail_products` FOREIGN KEY (`idProduct`) REFERENCES `product` (`idProduct`),
  ADD CONSTRAINT `fk_saledetail_sale` FOREIGN KEY (`idSale`) REFERENCES `sale` (`idSale`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

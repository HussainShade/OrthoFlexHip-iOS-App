-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2024 at 05:34 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `orthoflexhip_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `schedule_date` date DEFAULT NULL,
  `schedule_time` time DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `request_date` date DEFAULT NULL,
  `status` enum('Pending','Completed','Approved','Rejected') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`id`, `patient_id`, `doctor_id`, `schedule_date`, `schedule_time`, `reason`, `request_date`, `status`) VALUES
(111, 3, 1, '2024-02-12', '12:00:00', 'Mobility issues', '2024-05-07', 'Completed'),
(115, 4, 1, '2024-05-24', '10:00:00', 'uciciv', '2024-05-07', 'Approved'),
(116, 2, 1, '2024-05-24', '09:00:00', 'Follow-up appointment', '2024-05-07', 'Rejected'),
(117, 3, 1, '2024-05-09', '12:00:00', 'Orthopedic evaluation', '2024-05-08', 'Approved'),
(118, 6, 1, '2024-05-13', '12:00:00', 'Mobility issues', '2024-05-08', 'Pending'),
(119, 7, 1, '2024-05-14', '01:00:00', 'Post-surgery check', '2024-05-08', 'Approved'),
(120, 8, 1, '2024-05-10', '09:00:00', 'Follow-up appointment', '2024-05-08', 'Pending'),
(121, 9, 1, '2024-05-22', '10:00:00', 'New symptoms', '2024-05-08', 'Approved'),
(122, 10, 1, '2024-05-22', '10:00:00', 'Medication adjustment', '2024-05-08', 'Pending'),
(123, 11, 1, '2024-05-24', '10:00:00', 'X-ray analysis', '2024-05-08', 'Approved'),
(124, 12, 1, '2024-05-24', '10:00:00', 'Injury assessment', '2024-05-08', 'Approved'),
(125, 12, 1, '2024-05-24', '12:00:00', 'Medication adjustment', '2024-05-08', 'Pending'),
(126, 1, 1, '2024-05-24', '12:00:00', 'Rehabilitation plan', '2024-05-08', 'Approved'),
(127, 4, 1, '2024-05-15', '09:00:00', 'Follow-up appointment', '2024-05-08', 'Pending'),
(128, 3, 1, '2024-05-15', '09:00:00', 'Follow-up appointment', '2024-05-08', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `id` int(5) NOT NULL,
  `username` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `profile_photo` text NOT NULL,
  `age` int(3) NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `dob` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`id`, `username`, `password`, `name`, `profile_photo`, `age`, `gender`, `mobile`, `dob`) VALUES
(1, 'doc101', '12345', 'Dr. Sajith', 'image/WhatsApp Image 2024-02-24 at 14.24.08_99f1bb69.jpg', 29, 'Male', '9946560805', '16-04-1995');

-- --------------------------------------------------------

--
-- Table structure for table `hipscore`
--

CREATE TABLE `hipscore` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `pain` varchar(10) NOT NULL,
  `distance_walked` varchar(10) NOT NULL,
  `activities` varchar(10) NOT NULL,
  `public_transportation` varchar(10) NOT NULL,
  `support` varchar(10) NOT NULL,
  `limp` varchar(10) NOT NULL,
  `stairs` varchar(10) NOT NULL,
  `sitting` varchar(10) NOT NULL,
  `section_2` varchar(10) NOT NULL,
  `total_degree_of_flexion` varchar(10) NOT NULL,
  `total_degree_of_abduction` varchar(10) NOT NULL,
  `total_degree_of_ext_rotation` varchar(10) NOT NULL,
  `total_degree_of_adduction` varchar(10) NOT NULL,
  `score` int(5) NOT NULL,
  `score_result` enum('Poor','Fair','Good','Excellent') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `hipscore`
--

INSERT INTO `hipscore` (`id`, `patient_id`, `pain`, `distance_walked`, `activities`, `public_transportation`, `support`, `limp`, `stairs`, `sitting`, `section_2`, `total_degree_of_flexion`, `total_degree_of_abduction`, `total_degree_of_ext_rotation`, `total_degree_of_adduction`, `score`, `score_result`) VALUES
(88, 2, '10', '5', '2', '1', '5', '0', '0', '0', '4', '0', '0.4', '0.3', '0.15', 27, 'Poor'),
(89, 2, '30', '5', '2', '0', '5', '0', '1', '0', '4', '0', '0.4', '0.2', '0.15', 47, 'Poor'),
(90, 1, '44', '8', '2', '0', '5', '0', '0', '0', '4', '0', '0.4', '0.1', '0.15', 63, 'Poor'),
(91, 3, '30', '5', '2', '0', '5', '0', '0', '0', '4', '0', '0.6', '0.1', '0.1', 46, 'Poor'),
(92, 4, '44', '11', '4', '1', '11', '11', '4', '5', '4', '0', '0.4', '0.2', '0.1', 95, 'Excellent'),
(93, 5, '40', '11', '0', '0', '5', '0', '0', '0', '0', '0', '0.2', '0.2', '0.1', 56, 'Poor'),
(94, 5, '44', '8', '2', '0', '7', '0', '1', '3', '4', '0', '0.4', '0.2', '0.05', 69, 'Poor'),
(96, 6, '44', '11', '4', '0', '11', '11', '4', '5', '4', '0', ' 0.4', ' 0.1', ' 0.1', 94, 'Excellent'),
(97, 7, '30', '11', '4', '0', '11', '11', '4', '5', '4', '0', ' 0.4', ' 0.1', ' 0.1', 80, 'Good'),
(98, 8, '10', '11', '4', '0', '11', '11', '4', '5', '4', '0', ' 0.4', ' 0.1', ' 0.1', 60, 'Poor'),
(99, 9, '20', '11', '4', '0', '11', '11', '4', '5', '4', '0', ' 0.4', ' 0.1', ' 0.1', 70, 'Fair'),
(100, 10, '30', '11', '4', '0', '11', '11', '4', '5', '4', '0', ' 0.4', ' 0.1', ' 0.1', 80, 'Good'),
(101, 11, '40', '11', '4', '0', '11', '11', '4', '5', '4', '0', ' 0.4', ' 0.1', ' 0.1', 90, 'Excellent'),
(102, 12, '44', '11', '4', '0', '11', '11', '4', '5', '4', '0', ' 0.4', ' 0.1', ' 0.1', 94, 'Excellent');

-- --------------------------------------------------------

--
-- Table structure for table `medication`
--

CREATE TABLE `medication` (
  `id` int(5) NOT NULL,
  `patient_id` int(5) NOT NULL,
  `antibiotics` varchar(100) NOT NULL,
  `analgesics` varchar(100) NOT NULL,
  `antacids` varchar(100) NOT NULL,
  `anti_edema_drugs` varchar(100) NOT NULL,
  `tromboprophylaxis` varchar(100) NOT NULL,
  `supportive_drugs` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `medication`
--

INSERT INTO `medication` (`id`, `patient_id`, `antibiotics`, `analgesics`, `antacids`, `anti_edema_drugs`, `tromboprophylaxis`, `supportive_drugs`) VALUES
(39, 2, 'INJ.CEFGLOBE FORTE 1.5GM', 'TAB.ZERODOL TH MAX', 'TAB.PAN D', 'TAB.ENZITRA-DS', 'TAB.APIXABAN', 'TAB.CISS-Q'),
(40, 5, 'INJ.CEFGLOBE FORTE 1.5GM', 'TAB.ZERODOL TH MAX', 'INJ.PAN 40MG', 'TAB.LYMPEDIM', 'TAB.APIXABAN', 'TAB.TENDOCARE FORTE'),
(41, 1, 'INJ REFLIN 1GM', 'TAB.ZERODOL TH MAX', 'INJ.PAN 40MG', 'TAB.CHYMORAL FORTE', 'TAB.RIVAROXABAN', 'TAB.CISS-Q'),
(42, 3, 'INJ REFLIN 1GM', 'TAB.ZERODOL-P', 'TAB RANTAC 15OMG', 'TAB.PHLOGAM', 'INJ HEPARIN 5000 IU', 'TAB.CISS-Q'),
(43, 4, 'INJ REFLIN 1GM', 'CAPMYORIL 4MG', 'INJ.PAN 40MG', 'TAB.ENZITRA-DS', 'INJ HEPARIN 5000 IU', 'TAB.TENDOCARE FORTE'),
(45, 5, 'INJ.CEFGLOBE FORTE 1.5GM', 'TAB.ZERODOL TH MAX', 'INJ.PAN 40MG', 'TAB.ENZITRA-DS', 'TAB.RIVAROXABAN', 'OTAB.COBUILT PLUS'),
(49, 1, 'INJ.PAN 40MG', 'TAB.ENZITRA-DS', 'TAB.APIXABAN', 'INJ.CEFGLOBE FORTE 1.5GM', 'TAB.TENDOCARE FORTE', 'TAB.ZERODOL TH MAX'),
(54, 6, 'INJ.PAN 40MG', 'TAB.ENZITRA-DS', 'TAB.APIXABAN', 'INJ.CEFGLOBE FORTE 1.5GM', 'TAB.TENDOCARE FORTE', 'TAB.ZERODOL TH MAX'),
(55, 7, 'INJ.PAN 40MG', 'TAB.ENZITRA-DS', 'TAB.APIXABAN', 'INJ.CEFGLOBE FORTE 1.5GM', 'TAB.TENDOCARE FORTE', 'TAB.ZERODOL TH MAX'),
(56, 8, 'INJ.PAN 40MG', 'TAB.ENZITRA-DS', 'TAB.APIXABAN', 'INJ.CEFGLOBE FORTE 1.5GM', 'TAB.TENDOCARE FORTE', 'TAB.ZERODOL TH MAX'),
(57, 9, 'INJ.PAN 40MG', 'TAB.ENZITRA-DS', 'TAB.APIXABAN', 'INJ.CEFGLOBE FORTE 1.5GM', 'TAB.TENDOCARE FORTE', 'TAB.ZERODOL TH MAX'),
(58, 10, 'INJ.PAN 40MG', 'TAB.ENZITRA-DS', 'TAB.APIXABAN', 'INJ.CEFGLOBE FORTE 1.5GM', 'TAB.TENDOCARE FORTE', 'TAB.ZERODOL TH MAX'),
(59, 11, 'INJ.PAN 40MG', 'TAB.ENZITRA-DS', 'TAB.APIXABAN', 'INJ.CEFGLOBE FORTE 1.5GM', 'TAB.TENDOCARE FORTE', 'TAB.ZERODOL TH MAX'),
(60, 12, 'INJ.PAN 40MG', 'TAB.ENZITRA-DS', 'TAB.APIXABAN', 'INJ.CEFGLOBE FORTE 1.5GM', 'TAB.TENDOCARE FORTE', 'TAB.ZERODOL TH MAX');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `id` int(11) NOT NULL,
  `hospital_id` varchar(20) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `profile_photo` text NOT NULL,
  `age` int(11) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `height` decimal(5,2) NOT NULL,
  `weight` decimal(5,2) NOT NULL,
  `problem` varchar(255) NOT NULL,
  `admitted_date` date NOT NULL,
  `discharge_date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `suggested_videos` text NOT NULL,
  `pre_xray_image` text NOT NULL,
  `post_xray_image` text NOT NULL,
  `discharge_summary_pdf` text NOT NULL,
  `feedback` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`id`, `hospital_id`, `username`, `password`, `name`, `profile_photo`, `age`, `gender`, `mobile`, `height`, `weight`, `problem`, `admitted_date`, `discharge_date`, `status`, `suggested_videos`, `pre_xray_image`, `post_xray_image`, `discharge_summary_pdf`, `feedback`) VALUES
(1, 'SMCH1100', 'pat201', '67890', 'Ragunath', 'image/1.jpeg', 30, 'Male', '9876543210', 180.00, 70.20, 'Osteoarthritis', '2023-12-04', '2023-12-16', 'Discharged', '', 'image/WhatsApp Image 2023-10-05 at 12.05.42_14bca9ac.jpg', 'image/WhatsApp Image 2023-10-05 at 12.07.14_57437b0a.jpg', 'discharge_summary/613858802-Discharge-Summary.pdf', 'Your app made it so much easier to track my progress after surgery, thank you!'),
(2, 'SMCH1101', 'pat202', '67890', 'Pooja Sri', 'image/2.jpeg', 28, 'Female', '7677689966', 168.00, 65.00, 'Hip bursitis', '2023-12-15', '2023-12-31', 'Discharged', '', 'image/WhatsApp Image 2023-10-05 at 12.05.42_14bca9ac.jpg', 'image/WhatsApp Image 2023-10-05 at 12.07.14_57437b0a.jpg', 'discharge_summary/613858802-Discharge-Summary.pdf', 'I appreciate how user-friendly your application is, it really simplified my post-orthopaedic care routine.'),
(3, 'SMCH1102', 'pat203', '67890', 'Sohail', 'image/3.jpeg', 24, 'Male', '8547486898', 174.00, 70.20, 'Hip tendinitis', '2023-12-26', '2024-01-08', 'Discharged', '', 'image/WhatsApp Image 2023-10-05 at 12.05.42_14bca9ac.jpg', 'image/WhatsApp Image 2023-10-05 at 12.07.14_57437b0a.jpg', 'discharge_summary/613858802-Discharge-Summary.pdf', 'As someone who\'s not tech-savvy, I found your app intuitive and immensely helpful in managing my recovery.'),
(4, 'SMCH1103', 'pat204', '67890', 'John', 'image/4.jpeg', 20, 'Male', '9656575878', 176.00, 70.20, 'Perthes disease', '2024-01-05', '2024-01-17', 'Discharged', '', 'image/WhatsApp Image 2023-10-05 at 12.05.42_14bca9ac.jpg', 'image/WhatsApp Image 2023-10-05 at 12.07.14_57437b0a.jpg', 'discharge_summary/613858802-Discharge-Summary.pdf', 'The accuracy of the ratings and the detailed insights provided by your app helped me make informed decisions about my treatment plan.'),
(5, 'SMCH1104', 'pat205', '67890', 'Rohan', 'image/5.jpeg', 32, 'Male', '6647647658', 180.00, 82.00, 'Rheumatoid arthritis', '2024-01-22', '2024-02-09', 'Discharged', '', 'image/WhatsApp Image 2023-10-05 at 12.05.42_14bca9ac.jpg', 'image/WhatsApp Image 2023-10-05 at 12.07.14_57437b0a.jpg', 'discharge_summary/613858802-Discharge-Summary.pdf', 'The responsiveness of your application significantly reduced my anxiety during the recovery process.'),
(6, 'SMCH1105', 'pat206', '67890', 'Hema', 'image/6.jpeg', 25, 'Female', '8657645732', 168.00, 65.00, 'Bone fracture', '2024-02-11', '2024-02-27', 'Discharged', '', 'image/WhatsApp Image 2023-10-05 at 12.05.42_14bca9ac.jpg', 'image/WhatsApp Image 2023-10-05 at 12.07.14_57437b0a.jpg', 'discharge_summary/613858802-Discharge-Summary.pdf', 'I\'m impressed by the efficiency of your app in minimizing data usage while providing comprehensive medical support.'),
(7, 'SMCH1106', 'pat207', '67890', 'Gautham', 'image/7.jpeg', 47, 'Male', '9904545671', 172.00, 75.00, 'Hip pointer', '2024-02-16', '2024-03-03', 'Discharged', '', 'image/WhatsApp Image 2023-10-05 at 12.05.42_14bca9ac.jpg', 'image/WhatsApp Image 2023-10-05 at 12.07.14_57437b0a.jpg', 'discharge_summary/613858802-Discharge-Summary.pdf', 'Your app saved me countless hours of research by compiling all the necessary post-orthopaedic care information in one accessible platform.'),
(8, 'SMCH1107', 'pat208', '67890', 'Rajesh', 'image/8.jpeg', 49, 'Male', '6337098664', 172.00, 75.00, 'Bone fracture', '2024-02-28', '2024-03-21', 'Discharged', '', 'image/WhatsApp Image 2023-10-05 at 12.05.42_14bca9ac.jpg', 'image/WhatsApp Image 2023-10-05 at 12.07.14_57437b0a.jpg', 'discharge_summary/613858802-Discharge-Summary.pdf', 'The development time you invested in creating this app truly shows in its polished interface and seamless functionality.'),
(9, 'SMCH1108', 'pat209', '67890', 'Soniya', 'image/9.jpeg', 44, 'Female', '9767752134', 165.00, 65.00, 'Hip dysplasia', '2024-03-23', '2024-04-18', 'Discharged', '', 'image/WhatsApp Image 2023-10-05 at 12.05.42_14bca9ac.jpg', 'image/WhatsApp Image 2023-10-05 at 12.07.14_57437b0a.jpg', 'discharge_summary/613858802-Discharge-Summary.pdf', 'Using your app felt like having a personal assistant guiding me through each step of my recovery journey.'),
(10, 'SMCH1109', 'pat210', '67890', 'Hemanth', 'image/10.jpeg', 26, 'Male', '7547648588', 182.00, 75.00, 'Hip dislocation', '2024-04-19', '2024-05-14', 'Admitted', '', 'image/WhatsApp Image 2023-10-05 at 12.05.42_14bca9ac.jpg', 'image/WhatsApp Image 2023-10-05 at 12.07.14_57437b0a.jpg', 'discharge_summary/613858802-Discharge-Summary.pdf', 'I\'ve recommended your app to friends and family undergoing orthopaedic procedures because of its reliability and effectiveness.'),
(11, 'SMCH1110', 'pat211', '67890', 'Priya', 'image/11.jpeg', 30, 'Female', '9768758758', 170.00, 65.00, 'Muscles strain', '2024-04-28', '2024-05-21', 'Admitted', '', 'image/WhatsApp Image 2023-10-05 at 12.05.42_14bca9ac.jpg', 'image/WhatsApp Image 2023-10-05 at 12.07.14_57437b0a.jpg', 'discharge_summary/613858802-Discharge-Summary.pdf', 'The seamless integration of your app with my daily routine made post-orthopaedic care feel less daunting and more manageable.'),
(12, 'SMCH1111', 'pat212', '67890', 'Vishal', 'image/12.jpeg', 54, 'Male', '8545646869', 175.00, 75.00, 'Hip instability', '2024-05-02', '2024-05-28', 'Admitted', '', 'image/WhatsApp Image 2023-10-05 at 12.05.42_14bca9ac.jpg', 'image/WhatsApp Image 2023-10-05 at 12.07.14_57437b0a.jpg', 'discharge_summary/613858802-Discharge-Summary.pdf', 'Your application exceeded my expectations with its comprehensive features, from tracking medications to scheduling appointments, it\'s truly a lifesaver.');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `option_1` varchar(255) DEFAULT NULL,
  `option_2` varchar(255) DEFAULT NULL,
  `option_3` varchar(255) DEFAULT NULL,
  `option_4` varchar(255) DEFAULT NULL,
  `option_5` varchar(255) DEFAULT NULL,
  `option_6` varchar(255) DEFAULT NULL,
  `option_7` varchar(255) DEFAULT NULL,
  `option_8` varchar(255) DEFAULT NULL,
  `option_9` varchar(255) DEFAULT NULL,
  `option_10` varchar(255) DEFAULT NULL,
  `option_11` varchar(255) DEFAULT NULL,
  `option_12` varchar(255) DEFAULT NULL,
  `option_13` varchar(255) DEFAULT NULL,
  `option_14` varchar(255) DEFAULT NULL,
  `option_15` varchar(255) DEFAULT NULL,
  `score_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `patient_id`, `question`, `option_1`, `option_2`, `option_3`, `option_4`, `option_5`, `option_6`, `option_7`, `option_8`, `option_9`, `option_10`, `option_11`, `option_12`, `option_13`, `option_14`, `option_15`, `score_value`) VALUES
(1, 1, '1. Age', 'None, or ignores it', 'Slight, occasional, no compromise in activity', 'Mild pain, no effect on average activities, rarely moderate pain with unusual activity, may take aspirin', 'Moderate pain, tolerable but makes concessions to pain. Some limitations of ordinary activity or work. May require occasional pain medication stronger than aspirin', 'Marked pain, serious limitation of activities', 'Totally disabled, crippled, pain in bed, bedridden', '', '', '', '', '', '', '', '', '', '{\"None, or ignores it\": 44, \"Slight, occasional, no compromise in activity\": 40, \"Mild pain, no effect on average activities, rarely moderate pain with unusual activity, may take aspirin\": 30, \"Moderate pain, tolerable but makes concessions to pain. Some limitations of ordinary activity or work. May require occasional pain medication stronger than aspirin\": 20, \"Marked pain, serious limitation of activities\": 10, \"Totally disabled, crippled, pain in bed, bedridden\": 0}'),
(2, 1, '2. Distance walked', 'Unlimited', 'Six blocks (30 minutes)', 'Two or three blocks (10 - 15 minutes)', 'Indoors only', 'Bed and chair only', '', '', '', '', '', '', '', '', '', '', '{\"Unlimited\": 11, \"Six blocks (30 minutes)\": 8, \"Two or three blocks (10 - 15 minutes)\": 5, \"Indoors only\": 2, \"Bed and chair only\": 0}'),
(3, 1, '3. Activities - shoes, socks', 'With ease', 'With difficulty', 'Unable to fit or tie', '', '', '', '', '', '', '', '', '', '', '', '', '{\"With ease\": 4, \"With difficulty\": 2, \"Unable to fit or tie\": 0}'),
(4, 1, '4. Public transportation', 'Able to use transportation (bus)', 'Unable to use public transportation (bus)', '', '', '', '', '', '', '', '', '', '', '', '', '', '{\"Able to use transportation (bus)\": 1, \"Unable to use public transportation (bus)\": 0}'),
(5, 1, '5. Support', 'None', 'Cane/Walking stick for long walks', 'Cane/Walking stick most of the time', 'One crutch', 'Two Canes/Walking sticks', 'Two crutches or not able to walk', '', '', '', '', '', '', '', '', '', '{\"None\": 11, \"Cane/Walking stick for long walks\": 7, \"Cane/Walking stick most of the time\": 5, \"One crutch\": 3, \"Two Canes/Walking sticks\": 2, \"Two crutches or not able to walk\": 0}'),
(6, 1, '6. Limp', 'None', 'Slight', 'Moderate', 'Severe or unable to walk', '', '', '', '', '', '', '', '', '', '', '', '{\"None\": 11, \"Slight\": 8, \"Moderate\": 5, \"Severe or unable to walk\": 0}'),
(7, 1, '7. Stairs', 'Normally without using a railing', 'Normally using a railing', 'In any manner', 'Unable to do stairs', '', '', '', '', '', '', '', '', '', '', '', '{\"Normally without using a railing\": 4, \"Normally using a railing\": 2, \"In any manner\": 1, \"Unable to do stairs\": 0}'),
(8, 1, '8. Sitting', 'Comfortably, ordinary chair for one hour', 'On a high chair for 30 minutes', 'Unable to sit comfortably on any chair', '', '', '', '', '', '', '', '', '', '', '', '', '{\"Comfortably, ordinary chair for one hour\": 5, \"On a high chair for 30 minutes\": 3, \"Unable to sit comfortably on any chair\": 0}'),
(9, 1, '9. Section - 2', 'Yes', 'No', '', '', '', '', '', '', '', '', '', '', '', '', '', '{\"Yes\": 4, \"No\": 0}'),
(10, 1, '10. Total degrees of Flexion', 'None', '0 > 8', '8 > 16', '16 > 24', '24 > 32', '32 > 40', '40 > 45', '45 > 55', '55 > 65', '65 > 70', '70 > 75', '75 > 80', '80 > 90', '90 > 100', '100 > 110', '{\"None\": 0, \"0 > 8\": 0.4, \"8 > 16\": 0.8, \"16 > 24\": 1.2, \"24 > 32\": 1.6, \"32 > 40\": 2, \"40 > 45\": 2.25, \"45 > 55\": 2.55, \"55 > 65\": 2.85, \"65 > 70\": 3, \"70 > 75\": 3.15, \"75 > 80\": 3.3, \"80 > 90\": 3.6, \"90 > 100\": 3.75, \"100 > 110\": 3.9}'),
(11, 1, '11. Total degrees of Abduction 1', 'None', '0 > 5', '5 > 10', '10 > 15', '15 > 20', '', '', '', '', '', '', '', '', '', '', '{\"None\": 0, \"0 > 5\": 0.2, \"5 > 10\": 0.4, \"10 > 15\": 0.6, \"15 > 20\": 0.65}'),
(12, 1, '12. Total degrees of Ext Rotation', 'None', '0 > 5', '5 > 10', '10 > 15', '', '', '', '', '', '', '', '', '', '', '', '{\"None\": 0, \"0 > 5\": 0.1, \"5 > 10\": 0.2, \"10 > 15\": 0.3}'),
(13, 1, '13. Total degrees of Abduction 2', 'None', '0 > 5', '5 > 10', '10 > 15', '', '', '', '', '', '', '', '', '', '', '', '{\"None\": 0, \"0 > 5\": 0.05, \"5 > 10\": 0.1, \"10 > 15\": 0.15}');

-- --------------------------------------------------------

--
-- Table structure for table `video`
--

CREATE TABLE `video` (
  `video_id` int(5) NOT NULL,
  `video_name` varchar(255) NOT NULL,
  `video_file` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `video`
--

INSERT INTO `video` (`video_id`, `video_name`, `video_file`) VALUES
(1, 'Exercise 1', 'video/VID-20240224-WA0001.mp4'),
(2, 'Exercise 2', 'video/VID-20240224-WA0002.mp4'),
(3, 'Exercise 3', 'video/VID-20240224-WA0003.mp4'),
(4, 'Exercise 4', 'video/VID-20240224-WA0004.mp4'),
(5, 'Exercise 5', 'video/VID-20240224-WA0001.mp4'),
(6, 'Exercise 6', 'video/VID-20240224-WA0002.mp4'),
(7, 'Exercise 7', 'video/VID-20240224-WA0003.mp4'),
(8, 'Exercise 8', 'video/VID-20240224-WA0004.mp4');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hipscore`
--
ALTER TABLE `hipscore`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `medication`
--
ALTER TABLE `medication`
  ADD PRIMARY KEY (`id`),
  ADD KEY `medication_fk_patient_id` (`patient_id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`video_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT for table `hipscore`
--
ALTER TABLE `hipscore`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `medication`
--
ALTER TABLE `medication`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=183;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `video`
--
ALTER TABLE `video`
  MODIFY `video_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `hipscore`
--
ALTER TABLE `hipscore`
  ADD CONSTRAINT `hipscore_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `medication`
--
ALTER TABLE `medication`
  ADD CONSTRAINT `medication_fk_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

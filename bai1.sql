USE rikkeiclinicdb;

DELIMITER //
CREATE PROCEDURE CancelAppointment(IN p_appointment_id INT)
BEGIN 
	UPDATE Appointments
    SET status = 'Cancel'
	WHERE appointment_id = p_appointment_id;
END
// DELIMITER ;

CALL CancelAppointment(101);

-- Lỗi: 
-- Không kiểm tra appointment có tồn tại hay không
-- Không kiểm tra trạng thái hiện tại ("Cancelled" rồi vẫn update)
-- Không trả về thông báo

DROP PROCEDURE IF EXISTS CancelAppointment;

DELIMITER //
CREATE PROCEDURE CancelAppointment(IN p_appointment_id INT)
BEGIN
    IF EXISTS (SELECT 1 FROM Appointments 
               WHERE appointment_id = p_appointment_id 
               AND status = 'Pending') THEN
        
        UPDATE Appointments
        SET status = 'Cancelled'
        WHERE appointment_id = p_appointment_id;
        
        SELECT 'Lịch khám đã được hủy thành công' AS Message;
    ELSE
        SELECT 'Lỗi: Không thể hủy lịch khám đã hoàn tất hoặc không hợp lệ' AS ErrorMessage;
    END IF;
END 
// DELIMITER ;

CALL CancelAppointment(101);

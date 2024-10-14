package kopo.aisw.basic_mvc.board.dao;

import org.springframework.dao.DataAccessException;
import java.util.List;
public interface BoardDAO {
    public List selectAllMemberList() throws DataAccessException;
}


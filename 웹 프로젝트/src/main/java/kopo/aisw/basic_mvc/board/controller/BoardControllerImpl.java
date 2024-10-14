package kopo.aisw.basic_mvc.board.controller;

import kopo.aisw.basic_mvc.board.service.BoardService;
import kopo.aisw.basic_mvc.board.vo.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
@Controller("boardController")
public class BoardControllerImpl implements BoardController {
    @Autowired
    private BoardService boardService;
    @Override
    @RequestMapping(value="/board/listArticles.do" ,method = RequestMethod.GET)
    public ModelAndView listArticles(HttpServletRequest request, HttpServletResponse response)
            throws Exception {


        String viewName = getViewName(request);
        System.out.println("viewName: " +viewName);
        List articlesList = boardService.listArticles();
        ModelAndView mav = new ModelAndView(viewName);
        mav.addObject("articlesList", articlesList);
        return mav;
    }
    // Request 정보를 문자로 변환
    private String getViewName(HttpServletRequest request) throws Exception {
        String contextPath = request.getContextPath();
        String uri = (String) request.getAttribute("javax.servlet.include.request_uri");
        if (uri == null || uri.trim().equals("")) {
            uri = request.getRequestURI();
        }
        int begin = 0;
        if (!((contextPath == null) || ("".equals(contextPath)))) {
            begin = contextPath.length();
        }
        int end;
        if (uri.indexOf(";") != -1) {
            end = uri.indexOf(";");
        } else if (uri.indexOf("?") != -1) {
            end = uri.indexOf("?");
        } else {
            end = uri.length();
        }
        String viewName = uri.substring(begin, end);
        if (viewName.indexOf(".") != -1) {
            viewName = viewName.substring(0, viewName.lastIndexOf("."));
        }
        if (viewName.lastIndexOf("/") != -1) {
            viewName = viewName.substring(viewName.lastIndexOf("/", 1), viewName.length());
        }
        return viewName;
    }
}

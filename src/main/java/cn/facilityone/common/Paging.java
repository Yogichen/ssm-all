package cn.facilityone.common;

import java.util.List;

public class Paging {
    private int page;
    private int start;
    private int limit;
    private int total;
    private List<?> list;

    public Paging() {
    }

    public Paging(int start, int limit) {
        this.start = start;
        this.limit = limit;
    }

    public Paging(int start, int limit, int total, List<?> list) {
        this.start = start;
        this.limit = limit;
        this.total = total;
        this.list = list;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<?> getList() {
        return list;
    }

    public void setList(List<?> list) {
        this.list = list;
    }
}
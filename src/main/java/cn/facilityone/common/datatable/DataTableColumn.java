package cn.facilityone.common.datatable;

public class DataTableColumn {
    public static final String ORDER_DEFAULT_NAME = "id";

    public static final String ORDER_TYPE_ASC = "asc";

    public static final String ORDER_TYPE_DESC = "desc";

    public static final String SEARCH_TYPE_INT = "int";

    public static final String SEARCH_TYPE_STRING = "string";

    public static final String SEARCH_TYPE_DATE = "date";

    public static final String SEARCH_TYPE_DATE_RANGE = "daterange";

    public static final String SEARCH_TYPE_BOOLEAN = "boolean";

    public static final String SEARCH_TYPE_ENUM = "enum";


    private String data;
    private String name;
    private boolean searchable;
    private boolean orderable;
    private DataTableSearch search;

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isSearchable() {
        return searchable;
    }

    public void setSearchable(boolean searchable) {
        this.searchable = searchable;
    }

    public boolean isOrderable() {
        return orderable;
    }

    public void setOrderable(boolean orderable) {
        this.orderable = orderable;
    }

    public DataTableSearch getSearch() {
        return search;
    }

    public void setSearch(DataTableSearch search) {
        this.search = search;
    }
}
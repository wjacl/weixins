package com.wja.base.common;

/**
 * 系统通用常量定义接口
 * 
 * @author wja
 * 
 */
public interface CommConstants {

    String SESSION_USER = "session_user";

    String SESSION_USER_ID = "session_user_id";

    String SESSION_USER_PRIV_PATHS = "session_user_priv_paths";

    String SESSION_LANG = "user_lang";

    int RESULT_ADD_OK = 1;

    int RESULT_UPDATE_OK = 2;

    int RESULT_DELETE_OK = 3;

    /**
     * 数据有效
     */
    byte DATA_VALID = 1;

    /**
     * 数据无效（已删除）
     */
    byte DATA_INVALID = 0;

    /**
     * 审核状态：草稿
     */
    String AUDIT_STATUS_DRAFT = "c";

    /**
     * 审核状态：待审核
     */
    String AUDIT_STATUS_WAIT = "w";

    /**
     * 审核状态：通过
     */
    String AUDIT_STATUS_PASS = "p";

    /**
     * 审核状态：未通过
     */
    String AUDIT_STATUS_NOT_PASS = "n";

}

package com.kjh.exam.demo.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class Ut {

	public static boolean empty(Object obj) {
		if (obj == null) {
			return true;
		}

		if (obj instanceof Integer) {
			return ((int) obj) == 0;
		}

		if (obj instanceof Long) {
			return ((long) obj) == 0;
		}
		
		if (obj instanceof String == false) {
			return true;
		}

		String str = (String) obj;

		return str.trim().length() == 0;
	}

	public static String f(String format, Object... args) {

		return String.format(format, args);
	}

	public static String jsHistoryBack(String msg) {

		if (msg == null) {
			msg = "";
		}
		return Ut.f("""
				<script>
				alert('%s');
				history.back();
				</script>
				""", msg);
	}

	public static String jsReplace(String msg, String replaceUri) {

		if (msg == null) {
			msg = "";
		}
		if (replaceUri == null) {
			replaceUri = "";
		}
		return Ut.f("""
				<script>
				alert('%s');
				location.replace('%s');
				</script>
				""", msg, replaceUri);
	}

	public static String getUriEncoded(String str) {
		try {
			return URLEncoder.encode(str, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return str;
		}
	}
}

package org.iesbelen.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public final class PasswordUtil {

    private PasswordUtil() {
    }

    public static String hash(String password) {
        try {
            byte[] digest = MessageDigest.getInstance("SHA-256")
                    .digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexadecimal = new StringBuilder(digest.length * 2);
            for (byte value : digest) {
                hexadecimal.append(String.format("%02x", value & 0xff));
            }
            return hexadecimal.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("SHA-256 no está disponible.", e);
        }
    }

    public static boolean matches(String password, String storedHash) {
        if (password == null || storedHash == null) {
            return false;
        }
        try {
            byte[] expected = decodeHex(storedHash);
            byte[] actual = MessageDigest.getInstance("SHA-256")
                    .digest(password.getBytes(StandardCharsets.UTF_8));
            return MessageDigest.isEqual(expected, actual);
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("SHA-256 no está disponible.", e);
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    private static byte[] decodeHex(String value) {
        if (value.length() != 64) {
            throw new IllegalArgumentException("Hash SHA-256 no válido.");
        }
        byte[] bytes = new byte[32];
        for (int i = 0; i < bytes.length; i++) {
            int high = Character.digit(value.charAt(i * 2), 16);
            int low = Character.digit(value.charAt(i * 2 + 1), 16);
            if (high < 0 || low < 0) {
                throw new IllegalArgumentException("Hash SHA-256 no válido.");
            }
            bytes[i] = (byte) ((high << 4) + low);
        }
        return bytes;
    }
}

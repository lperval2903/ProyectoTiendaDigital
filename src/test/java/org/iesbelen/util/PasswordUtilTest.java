package org.iesbelen.util;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

class PasswordUtilTest {

    @Test
    void hashesAndVerifiesPasswords() {
        String hash = PasswordUtil.hash("12345678");

        assertNotEquals("12345678", hash);
        assertTrue(PasswordUtil.matches("12345678", hash));
        assertFalse(PasswordUtil.matches("incorrecta", hash));
    }

    @Test
    void rejectsMalformedStoredHashes() {
        assertFalse(PasswordUtil.matches("usuario", "not-a-hash"));
        assertFalse(PasswordUtil.matches(null, PasswordUtil.hash("usuario")));
    }
}

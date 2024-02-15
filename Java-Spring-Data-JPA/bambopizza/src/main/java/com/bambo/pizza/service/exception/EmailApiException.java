package com.bambo.pizza.service.exception;

public class EmailApiException extends RuntimeException {
    public EmailApiException() {
        super("Error sending mail...");
    }
}

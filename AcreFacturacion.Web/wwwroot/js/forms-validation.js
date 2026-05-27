document.addEventListener("DOMContentLoaded", function () {
    activarValidacionEnTiempoReal();
    restringirEntradas();
});

function activarValidacionEnTiempoReal() {
    if (!window.jQuery || !$.validator) {
        return;
    }

    $("form").each(function () {
        $.validator.unobtrusive.parse(this);
    });

    $("input, select, textarea").on("input change blur", function () {
        const form = $(this).closest("form");

        if (form.data("validator")) {
            $(this).valid();
        }
    });
}

function restringirEntradas() {
    document.querySelectorAll("[data-validation-type]").forEach(function (input) {
        input.addEventListener("input", function () {
            const type = input.dataset.validationType;
            let value = input.value;

            if (type === "identity") {
                value = value.replace(/[^0-9-]/g, "");
            }

            if (type === "phone") {
                value = value.replace(/[^0-9+\-\s]/g, "");
            }

            if (type === "product-code") {
                value = value.replace(/[^a-zA-Z0-9_.-]/g, "");
            }

            if (type === "customer-name") {
                value = value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ0-9\s.\-&]/g, "");
            }

            if (type === "product-name") {
                value = value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ0-9\s.\-_]/g, "");
            }

            input.value = value;
        });
    });

    document.querySelectorAll("[data-number-type]").forEach(function (input) {
        input.addEventListener("keydown", function (event) {
            const blockedKeys = ["e", "E", "+", "-"];

            if (blockedKeys.includes(event.key)) {
                event.preventDefault();
            }
        });

        input.addEventListener("input", function () {
            const type = input.dataset.numberType;

            if (type === "integer") {
                input.value = input.value.replace(/[^0-9]/g, "");

                if (input.value.length > 6) {
                    input.value = input.value.substring(0, 6);
                }
            }

            if (type === "decimal") {
                input.value = input.value.replace(",", ".");
                input.value = input.value.replace(/[^0-9.]/g, "");

                const parts = input.value.split(".");

                if (parts.length > 2) {
                    input.value = parts[0] + "." + parts.slice(1).join("");
                }

                if (parts[0] && parts[0].length > 6) {
                    parts[0] = parts[0].substring(0, 6);
                    input.value = parts.join(".");
                }
            }
        });
    });
}
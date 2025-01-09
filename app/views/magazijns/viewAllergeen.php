<?php require_once APPROOT . '/views/includes/header.php'; ?>

<div class="container">
    <div class="row mt-3" style="display: <?= $data['messageVisibility'] ?>;">
        <div class="col-2"></div>
        <div class="col-8">
            <div class="alert text-center <?= $data['messageColor'] ?>" role="alert">
                <?= $data['message']; ?>
            </div>
            <div class="col-2"></div>
        </div>
    </div>
    <div class="row">
        <div class="col-2"></div>
        <div class="col-8">
            <h3>Allergeen informatie</h3>
            <ul>
                <li>Product naam: <?= $data['ProductNaam'] ?></li>
                <li>Product barcode: <?= $data['ProductBarcode'] ?></li>
            </ul>
        </div>
        <div class="col-2"></div>
    </div>


    <div class="row">
        <div class="col-2"></div>
        <div class="col-8">
            <table class="table table-hover">
                <thead>
                    <th>Naam</th>
                    <th>Omschrijving</th>
                </thead>

                <?php
                if (is_null($data['Allergenen'])) {
                    echo "
                    <tr>
                        <td colspan='7' class='text-center'>
                        Geen allergenen.
                        </td>
                    </tr>
                    ";
                } else {
                    foreach ($data['Allergenen'] as $Allergeen) {
                        echo "<tr>
                        <td>{$Allergeen->AllergeenNaam}</td>
                        <td>{$Allergeen->Omschrijving}</td>
                        ";
                    }
                }
                ?>
            </table>
            <a href="<?= URLROOT; ?>/magazijns/index">Terug</a>
        </div>
        <div class="col-2"></div>
    </div>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>
<!-- <td>
<a href='" . URLROOT . "/countries/update/{$country->Id}'>
<i class='bi bi-pencil-square'></i>
</a>
</td>
<td>
<a href='" . URLROOT . "/countries/delete/{$country->Id}'>
<i class='bi bi-trash'></i>
</a>
</td>             -->
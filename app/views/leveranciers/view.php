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
            <h3>Geleverde producten</h3>
            <ul>
                <li>Leverancier: <?= $data['LeverancierNaam'] ?></li>
                <li>Contact persoon: <?= $data['ContactPersoon'] ?></li>
                <li>Leverancier Nummer: <?= $data['LeverancierNummer'] ?></li>
                <li>Mobiel: <?= $data['Mobiel'] ?></li>
            </ul>
        </div>
        <div class="col-2"></div>
    </div>


    <div class="row">
        <div class="col-2"></div>
        <div class="col-8">
            <table  class="table table-hover">
                <thead>
                    <th>Product naam</th>
                    <th>Aantal aanwezig</th>
                    <th>Verpakings inhoud in kilogram</th>
                    <th>Datum levering</th>
                    <th>Nieuwe levering</th>
                </thead>

                <?php
            foreach ($data['Products']  as $Product) {
                echo "<tr>
                <td>{$Product->ProductNaam}</td>
                <td>{$Product->AantalAanwezig}</td>
                <td>{$Product->VerpakingsInhoudKilogram}</td>
                <td>{$Product->DatumLevering}</td>
                <td><a href='" . URLROOT . "/Leveranciers/AddLevering/{$Product->ProductId}'><i class='bi bi-plus-lg'></i></a></td>
                ";
            }
            ?>
            </table>
            <a href="<?= URLROOT; ?>/Leveranciers/index">Terug</a>
        </div>
        <div class="col-2"></div>
    </div>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>

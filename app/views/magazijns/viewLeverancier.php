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
            <h3>Leverancier informatie</h3>
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
                    <th>Datum levering</th>
                    <th>Levering aantal</th>
                    <th>Datum eerst volgende levering</th>
                </thead>

                <?php
            foreach ($data['Products']  as $Product) {
                if(is_null($Product->DatumEerstVolgendeLevering)){
                    $DatumEerstVolgendeLevering = "Niet bekend.";
                }else{
                   $DatumEerstVolgendeLevering = $Product->DatumEerstVolgendeLevering;
                }
                echo "<tr>
                <td>{$Product->ProductNaam}</td>
                <td>{$Product->DatumLevering}</td>
                <td>{$Product->LeveringAantal}</td>
                <td>{$DatumEerstVolgendeLevering}</td>
                ";
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
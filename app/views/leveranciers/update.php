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
            <h3>Leverancier wijzigen</h3>
        </div>
        <div class="col-2"></div>
    </div>
    <form action="<?= URLROOT; ?>/Leveranciers/UpdateLeverancier/<?= $data['LeverancierId']; ?>" method="post">
                <div class="mb-3">
                    <label for="LeverancierNaam" class="form-label">Naam:</label>
                    <input name="LeverancierNaam" type="text" class="form-control" id="LeverancierNaam" placeholder="Naam..." value="<?= $data['LeverancierNaam'] ?>">
                    <div class="errorFrom"><?= $data['NaamError'] ?></div>
                </div>
                <div class="mb-3">
                    <label for="ContactPersoon" class="form-label">Contact persoon:</label>
                    <input name="ContactPersoon" type="text" class="form-control" id="ContactPersoon" placeholder="Contact persoon..." value="<?= $data['ContactPersoon'] ?>">
                    <div class="errorFrom"><?= $data['ContactPersoonError'] ?></div>
                </div>
                <div class="mb-3">
                    <label for="LeverancierNummer" class="form-label">Leverancier nummer:</label>
                    <input name="LeverancierNummer" type="text" class="form-control" id="LeverancierNummer" placeholder="Leverancier nummer..." value="<?= $data['LeverancierNummer'] ?>">
                    <div class="errorFrom"><?= $data['LeverancierNummerError'] ?></div>
                </div>
                <div class="mb-3">
                    <label for="Mobiel" class="form-label">Mobiel:</label>
                    <input name="Mobiel" type="text" class="form-control" id="Mobiel" placeholder="123456789" value="<?= $data['Mobiel'] ?>">
                    <div class="errorFrom"><?= $data['MobielError'] ?></div>
                </div>
                <div class="mb-3">
                    <label for="Straat" class="form-label">Straat:</label>
                    <input name="Straat" type="text" class="form-control" id="Straat" placeholder="Straat..." value="<?= $data['Straat'] ?>">
                    <div class="errorFrom"><?= $data['StraatError'] ?></div>
                </div>
                <div class="mb-3">
                    <label for="Huisnummer" class="form-label">Huisnummer:</label>
                    <input name="Huisnummer" type="text" class="form-control" id="Huisnummer" placeholder="Huisnummer..." value="<?= $data['Huisnummer'] ?>">
                    <div class="errorFrom"><?= $data['HuisnummerError'] ?></div>
                </div>
                <div class="mb-3">
                    <label for="Postcode" class="form-label">Postcode:</label>
                    <input name="Postcode" type="text" class="form-control" id="Postcode" placeholder="Postcode..." value="<?= $data['Postcode'] ?>">
                    <div class="errorFrom"><?= $data['PostcodeError'] ?></div>
                </div>
                <div class="mb-3">
                    <label for="Stad" class="form-label">Stad:</label>
                    <input name="Stad" type="text" class="form-control" id="Stad" placeholder="Stad..." value="<?= $data['Stad'] ?>">
                    <div class="errorFrom"><?= $data['StadError'] ?></div>
                </div>


                <div class="d-grid">
                    <button type="submit" class="btn btn-success">Sla op</button>
                </div>
            </form>

    <div class="row">
        <div class="col-2"></div>
        <div class="col-8">
           
            <a href="<?= URLROOT; ?>/leveranciers/edit">Terug</a>
        </div>
        <div class="col-2"></div>
    </div>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>
